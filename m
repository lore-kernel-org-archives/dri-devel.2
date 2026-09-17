Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F4C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB0810E430;
	Thu, 17 Sep 2026 07:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Fkbtd11e";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5CC10E430
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:22:59 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so2322125e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1789629777; x=1790234577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jtER79YEfUdewNdGI8bNbynmacCVTSf1eVDUEcusWmw=;
 b=Fkbtd11eOqXc9gpPb4bzV1Yotu6yLV+eESKLHQqhd2gUU+wlYEtFHo4DeSfNbkiMu5
 LS9dpyf+xIL+mdfD++z+hGPYnnE7GM3P2f8GgM60IYerT1mgIeMGhBHAB0Si0t9vMnkd
 WAvhGHEifPwslEoF1dXijgi5ERwA/7YXtxMuSDxvCanDlZ+T7euPWz2AGok50f/qytYq
 0ybXj9rE6Iae8pO/plG/+A/l/QO0D2rEGiSdiq+HtFq33nl1ew+ITrNEIjQLbd8a1M3G
 h+QB9JooYso/TFg+IgHqCJDJP1rSE0ofKksEoyYLGIwvX/3Ij2jpqmIEdKu2EhKZWiqQ
 DwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789629777; x=1790234577;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jtER79YEfUdewNdGI8bNbynmacCVTSf1eVDUEcusWmw=;
 b=fhelBnTUH+Q/4rE7xcQUuzaR98HkdUqv/lwfHdYXTa3qiuMkCYFRqryEM4+VTyelyz
 jPePcsfDAzDCSSZ5CFwqyTLMKdyJsZWDkJR1UI97WXa3Y6j5adfF3p3OfpnEoucg/dJU
 PgG4XFDTWwYDbUBiwfFPfgdORrvEPhKXGOYH3iLMBwB9m6xqAeqJMLzJwvbdU/y1Zwzm
 gb0pmnzgacQ4vFM8gyMW0G93L2HE+h2cViQ5bW/q2ugsjwyyCQtUKuPaj3S6A7s0FBuW
 oSW3WNCBrkVLwpm9tlxOZlhraBiIDJwEp99WG3wgMck6KIVwEsoO+2v7FS+eduhEsbTn
 YRwg==
X-Gm-Message-State: AFuF++kQ3oZUdloWTBCeMB38wlqfeOGkoNHvZQlga1ol0TAKcuC8xHfe
 nFxnNZ3Rc3e8nTTrUMJrXj3CGoPXSRCsG4LL/i3yBm2Jk1BfmOWTnPI2oA1hy0HPEGs=
X-Gm-Gg: AYBFou0gavCqx5qxQwrDfDDE4cv+XH+CRv9cybjMHhNePtmSlTq3ufCKWncfcIflrZ/
 0KuKVaeGiW5pEhxruZPOwZfvEdnVTVvXxjTiQu/u773TWMyKxsJrNxBMFW0BMdbFNQXy4zBJQSB
 QsxYkV0OebOVrWSsyzLKQ8KiqGG3fnnZVRAYsiUaC+oV1mxWE61Hog57Dhfi2uvTOT+sB3QE6cE
 yjCFVDOnrvYEU6Itan2PjRq5XfWio6tn+EEYsrm6UU/cJjZL5OI8bymNXoFPSlxOCxmyOH6RoTa
 X6/ycbsPZNe5lFDiJrbuqvjobcMv2Q8OAkSAv7kIk+On+IK9lTdi7RxP8d2rxfkkZ5flBbnh9Pd
 8zAq5A60S14cDGcjpa9xgsCpRx8nhFeyhr2h7gYJu+zklJxeF5cr/89L7A5yeZlQRlkXYCWZFmJ
 Kehm3NM/Y5vCC8UCUk9l4itxf/wqsxBkK/efbIU/uCMTOx/eeqXpHreJCURYAd1doaLSN0uQLPR
 bOtIVvMaBY7m30=
X-Received: by 2002:a05:600c:3547:b0:49c:fa20:cbfb with SMTP id
 5b1f17b1804b1-49eb73253demr61340245e9.18.1789629777083; 
 Thu, 17 Sep 2026 00:22:57 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd32c5e1sm76754145e9.5.2026.09.17.00.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 00:22:56 -0700 (PDT)
Message-ID: <d9481d22-5355-45da-81e0-a066260e568b@ursulin.net>
Date: Thu, 17 Sep 2026 08:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/sched: Protect entity->last_scheduled with
 spinlock
To: phasta@kernel.org, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260910075942.2000338-2-phasta@kernel.org>
 <20260910075942.2000338-5-phasta@kernel.org>
 <f186f871-064a-4f45-8987-fe9f2fb3fa1c@ursulin.net>
 <47731da478e8801dc9823ecf286e941020e30963.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <47731da478e8801dc9823ecf286e941020e30963.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On 16/09/2026 13:54, Philipp Stanner wrote:
> On Fri, 2026-09-11 at 09:17 +0100, Tvrtko Ursulin wrote:
>> Also, to repeat what I said before, I benchmarked this a bit under
>> extreme circumstances (4x non vsynced vkgears) and did not find a
>> regression in fps.
> 
> Does that mean you give this an official Tested-by: …
> ?

Not sure if it was the same version I tested back then so best I re-test 
it quickly once you post the rebase. I was actually planning to review 
it once sashiko is happy and Christian at least acks it, which he now did.

Regards,

Tvrtko

>> Here you can compact with the idiomatic:
>>
>>    prev = dma_fence_get(entity->last_scheduled);
> 
> Good idea, will do.
> 
> Thx,
> P.

