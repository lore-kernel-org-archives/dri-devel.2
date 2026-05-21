Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BD3CD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECE3310F210;
	Thu, 21 May 2026 06:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nZ7Ax7bM";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB7C10F057
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 06:30:28 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3698e34a567so5003444a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 23:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779345028; x=1779949828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yU7wIpLUjpDi+4dczL8E1lAAhwWnHyjdAM0tuVF9mxk=;
 b=nZ7Ax7bMCIlkxXdO0FW7oxo5Hcwbj9bOj3td/IuUTOUbP/ro/KQu1sY5J7kgcRGeDo
 0GCD8y+gykb5lkd2JTkP2Okd/bNikh8k9DfgQYzDRC+/33fQ3ZmMqXvrpmMHs5jaCi5W
 PlJbQXFLbcTwUdc7NTrR0rnXuYNdyaBW4yrrKmt/qiJlJofwBZRuABAVFEDfCOKrTkOj
 WQSx16XtCPqTbNSZqIilvNoTEtiHHzs4Wn4xP0yms8M26uwkq6fF7JhboAPn+SWj/qyy
 rdS1KT7k+Qa44NWVPJXu31yuM79uV64b55dPDvFLPULMUZ5NxqhKVY9G+fHWrBWLdymZ
 45mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779345028; x=1779949828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yU7wIpLUjpDi+4dczL8E1lAAhwWnHyjdAM0tuVF9mxk=;
 b=QHZgsFK3p4SvfSEyOCTe668CRus6/VQbsvRKkkWIa/BGDew9nG9cqq2D8/YRL9a0bO
 ArPwxEGq/g8NJc3zrpYNBfIAg+zKoMSIs+H8gl1NjRLbP65oU8yhBB7sJcDDUXQy2QbZ
 koGRwEi4P2Mc2RDN09Q60YxTnXpxTveCSvJt3ihzF62Tj7QlMdbPH2oG6S5KbLTXWGwc
 tG5e6mT+7vtZfd8Ksqdmcb/xoyfRCi4DehbfAkacqKdtMsbJqPDwxhxqWpoB1ad4RhVu
 aqdJB58rxSxRdrXend6N5pi7Q2m2O3C6IbS388JlUlvco9y0j6Wvv/f7cUqGiEzxxWGG
 OUng==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tropHDUpxRdKTsylZUojE18+Rx/p3tb9yMKhpbedjjsZJvkfeiWVuNMs6igqOmw7wAG0gpjMJ+Wk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVCgfkOc8tahIlctp4mq/nmsfVLkyPryYLS3IU67aB3FFkA+9j
 5lXux3OKgVkJbYVhfMOh4jU9ZCGxbcvs37TWrZ75Y/w16RlVErJWXmtO
X-Gm-Gg: Acq92OGHgODjyfvVemEaTiD0g4NAqCZ37nuN5iLvf+vZ4K3FovUHZak7AUjZIYhv7G/
 bEFIyKUjFUp1+SlIvuCBauMu7lZUyOUgHLLspPxWO+RjnEdJvIuOokxaszU4o81u1HOhblXcskR
 spAdVRauwHGYS5bQiRNLo0IyJS8TUUJ96Q6AtmOIL4J0u30GKOEzVRQ49gL4E+8IdDxTyctT44R
 aEuy7BxZai5DkXNiDXPKMpsMtxdPyXH/zb38gZ2t8kkmWVrNQ0GzZ3iVBsb8wVmqrBpSxumuyAI
 E2pKAS/OtzzxIi3kj5cCMWFB7bR89fJjB+tPTZgcGemKdMo7rYHvAnaKXY2uE4RvHcL71mgvQ9u
 40u4r6vEVweTURWR7TDF/Ezs1YnS/BcsEYrf6e0lQ8gf0e7pBFywHS2ZxLmh9A7aMYZP5KBP9cI
 y93zmYLLbB5QYI2zetyIC1+je2qUAyq+SUIxeEcl4idcGARjw=
X-Received: by 2002:a17:90b:50ce:b0:369:1dcf:4a56 with SMTP id
 98e67ed59e1d1-36a45637501mr1829423a91.21.1779345028014; 
 Wed, 20 May 2026 23:30:28 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d2083ecsm1880772a91.16.2026.05.20.23.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 23:30:27 -0700 (PDT)
Message-ID: <80e68e8e-3dfd-4472-91e5-bebc67df5358@gmail.com>
Date: Thu, 21 May 2026 12:00:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 marex@denx.de, valentin@compulab.co.il, philippe.schenker@toradex.com,
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
 <20260412053811.662461-2-tessolveupstream@gmail.com>
 <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
 <c4c33f14-0da0-447a-ab82-2e2f65c09c07@gmail.com>
 <7056b23b-ed81-4d79-b782-5cfcb0102ef7@gmail.com>
 <60a24977-b181-40e4-bcf6-38b65af293e2@gmail.com>
 <DI18PL73UQKR.2YZVZ21V69H7O@bootlin.com>
 <e88af0b7-388d-4b0a-8eb2-a367e24e84fb@gmail.com>
 <DIMMKNT9RHYM.1BRF1S1V5SIKI@bootlin.com>
 <1716be56-ac43-440b-a5df-58cbf571ba95@gmail.com>
 <DINH3J2SM26P.3KE6GE9VPB1OC@bootlin.com>
 <8a78aab6-918a-4bed-a913-05ecb559da4f@gmail.com>
 <DINOYRHFLDMD.1TD43L37DHA0T@bootlin.com>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <DINOYRHFLDMD.1TD43L37DHA0T@bootlin.com>
Content-Type: text/plain; charset=UTF-8
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



On 20-05-2026 23:18, Luca Ceresoli wrote:
> On Wed May 20, 2026 at 2:29 PM CEST, tessolveupstream wrote:
> 
>>>> Additionally, regarding the Tested-by tags you mentioned earlier,
>>>> should I carry them forward to both patches, or would you prefer them
>>>> only on the applicable patch?
>>>
>>> I'd say yes. People who sent these tags have tested a patch that is the sum
>>> of the two future patches, so I'd say it's OK to keep the R-by on both
>>> patches.
>>>
>>
>> Okay, I just wanted to confirm one point — when you mentioned R-by, are you
>> referring to the Reviewed-by tag? I wanted to make sure I understood it
>> correctly before carrying the tags forward in the next version. 🙂> Thanks for your patience. We'll get to the bottom of this issue! :)
> 
> Oops, I wrote R-by but I meant Tested-by.
>

Thanks for the confirmation.
 
> I don't think you received any other (Acked/Reviewed-by) tags.
> 

Yes, I have not received any other Acked-by or Reviewed-by tags.

> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

