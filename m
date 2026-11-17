Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534B606A89A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pYPW3//C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9317A10E06A;
	Tue, 17 Nov 2026 14:27:21 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A00C10E06A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:27:15 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso2094309f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 06:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794925634; x=1795530434;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wnAbz7Gl1f6zlRr2NWm/XchokgiwNgSv132i/6lKWwU=;
 b=pYPW3//CAACG1KNyEkIgD13NRywGFq4XLVWJvbSqjeC3Er9JfFPANBnGpoawWtjigb
 aOkw0RbmuDsSv3nPb/lI0AIsIlI0Z8aoNWQB5ph2FtGbya7fPxKGrLrl/+4HsOYoShAO
 Iv+bLTjE2gpKiW2/J1IfLxUxgPAvnJvuPFi14QCwkAP7RXuHSgW2E2Bu0ahVYUlo+KQI
 A14YPJy3puu8vLBr0KJHTY87oguzr/wJjo37GrGP7cCVSWF/oe/AZTf5tpQAndslT87L
 kPaAbic2stTVawZuoyi0niULjA+WIXah0AIXRRmhPzttxiUMQKzoRiuJR1zYXSXPfV4e
 T0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794925634; x=1795530434;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wnAbz7Gl1f6zlRr2NWm/XchokgiwNgSv132i/6lKWwU=;
 b=spEJFFmES+oTsm8cFi2L7nzciveg0vWj6Lc/0yNPp1ZjFxiafPuYLaQyLjbDmjIcrD
 M5pvT7loX9uAUXTqy3CPflqRV8EwMfv6t3dEuF2dzMdfpjb7CJ/VlhQKdDaoxkHTuJ8u
 8WGBiclE4my7LTJHc5F48FuR5vXJS8exGeLKB605G6BjDFlS7+QLXoRuyxlC9edmTh2t
 XMZUTS+S+VIUJ/5yMyQ/SwpETv7uh6EC1HC+Os//cD+sg5qViPjCKuM2PXAcBT07qvCX
 hrxTTHCdtuedcdog6C4SEKTO2FCl5w72+aXPoeN34jQO6tX9s1QHOVTRxdtccvfB33Ej
 N4eg==
X-Gm-Message-State: APuU4Z8wVUrmQDjHHk6XjNyLufo0NUST3L+vIsdzOWVlWrBwvMC2dxCC
 cTh6Hi0fRZuRYAadtU8rCqXQkJv7rRmCoFTr4hE+vhHc/seyOadG0Ug8TzTJJUhaB84=
X-Gm-Gg: AZFdTZfVv2LdgGMOwSyyeS7ws+QVDhCKfEJ/D8vkXIeAQtkys/eIZDhFipXDIFXb1fT
 753tRTC9ejgtE9fv7ChZdFIPO52EgKDpTvJThKwtpepi5isMhPr5Aa576Z5qu2IjwDPvcVl1xW+
 xqAWSSD+P+rxpYQz1hWYoc0AV5RIF/J/4aermcHQy0TzqYw0qp6EqyfAu+RHFJPDomlzZoPMCBT
 eMoCLeyv529BZXR9sqvY8vLlTMyGrn3mWQt3OQ+6VFl+F9YFG0Zn70oUuAsL5BWcuk9KrRBH255
 uvMfKvAE2RyR6KGFYZiUbl+t3X5Pmcrhi1m38wfEX5EwMU/Qgyq+rf3jqSbayGFC6f3ze3ophcA
 Hk17zP7N/CudcnGqeLdosu3yec8JzTL68iJvPULM57k3PxMa0pe5Jz9616N1UFtYSDJ+XOKFoP4
 vT/ujz2Ye6943V60bfdYM6xgrU4DArdjMH1LSFOFM6VoN6XtxHOOaJslj6ngvAyA0HOWU1g+Web
 KY7SxyX6I6tNAm6ImP76z19K8yAujpl1nSxw8MmxTRe4731wUkTmmQQtebAzKpyvlBkj2moHa23
 GOUzvDHulWjoX2XDRfOLHzbQx841V9ZC0b3+ieofLu3wVFjkfaAEog9W11di/XVyPXcgMQK1ZBr
 H3Q==
X-Received: by 2002:a05:6000:25c3:b0:491:4e13:fde5 with SMTP id
 ffacd0b85a97d-49c6fc9e61bmr33439745f8f.8.1794925633802; 
 Tue, 17 Nov 2026 06:27:13 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f77fc47sm28559146f8f.22.2026.11.17.06.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 06:27:13 -0800 (PST)
Message-ID: <c000f684-0989-4ac7-bd40-e6d224fe070b@baylibre.com>
Date: Tue, 17 Nov 2026 14:27:12 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/rocket: fix ignored return value in
 rocket_ioctl_submit
To: Kartik Nair <contact.kartikn@gmail.com>, tomeu@tomeuvizoso.net,
 ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260510200047.6117-1-contact.kartikn@gmail.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <20260510200047.6117-1-contact.kartikn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/05/2026 21:00, Kartik Nair wrote:
> rocket_ioctl_submit() calls rocket_ioctl_submit_job() in a loop but
> ignores its return value. If any job submission fails, the error is
> silently dropped and the function returns 0 (success) to userspace,
> leaving subsequent jobs potentially in an inconsistent state.
> 
> Fix this by propagating the error and breaking out of the loop on
> the first failure.

There's definitely a bug in there, but this approach is just replacing 
one incorrect behaviour with another.

After your change if there is an -EINTR generated from within the job 
submission, this will cause drmIoctl to retry the exact same job 
sequence, likely causing parts of the sequence to be repeated, possibly 
with negative consequences.

And on other error paths that would be bubbled up by your change, 
userspace won't be able to know which parts of the sequence ran vs failed.

I think we need a deeper change here. Is it possible to fully prepare 
and arm the whole job list first, without executing yet, returning an 
error code if anything goes wrong in the process?

Then the execution of the job list could happen as a second stage, 
hopefully without any possibility of failure.

Daniel

