Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F382606A327
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fxV13nCd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E4D10E807;
	Tue,  3 Nov 2026 14:25:04 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEB310E807
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:24:57 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso3502742a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 06:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793715896; x=1794320696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4TONlcxqo54iN78pAMzbzkX6q3qNAFO1iKV1Ffm2IVw=;
 b=fxV13nCdYkrNwylEFH55zBcf9ZvIO2Urtf0gwQbB3DBLnWrLAdPT/rezknoXkIUMmr
 fg2yWhBvGwYENu+cKpE3NylfUQoudgak3j+sBa0GvBl+5Gr4ngPy1JEPL7g5mI4/FhLj
 sYsPgETU3Ar2wTXwkg0U68G/xh8pTwJPbn1zNEAQI1j4J/jfnZOGvg41t3sEa12i4lr2
 rTFVYket77/E3WG+8hFHYZlR1Srhxog+zEU3vu+ZA148CWp0RvxTgQzQfpexfpUs3zBQ
 BlmSbu03tBh40pYropQOKhMmPG+fMhHRhK1ko4bmOf+eW7VatKQ5YxQsx2hXOOHR3kif
 TRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793715896; x=1794320696;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4TONlcxqo54iN78pAMzbzkX6q3qNAFO1iKV1Ffm2IVw=;
 b=Md8wXLjUhe+SzKzp9NZ4lgGUTzUl2SbdcPNJLp/TFqxI6H91fVip8VjZqenwF81NBd
 tqM0PNz+mPEtl36eyiGu6Hh2FisNEPhg7yFmSKLm+NBu8stbUNWpr/UdKSS81/ASz9Pz
 IGseRxq2GVdS/vypXtmMfPdqRKu4+55IzwYIFI5b1fMW1ZteY4EJ4WczMCp1fJGh5ceb
 Cvq1VFZE8FMsnzBBs/E/RMBh0IubXd4lRLaRLenObJB5NdaN/yTv55OOtV3GSYJQq0RU
 pHJlnCTC/Bh9Fb9xPjpZ6RGEfahYG9vrkRoub/QSl4F847lSYDC5aGDIqIZb5TpqVy2C
 EQEA==
X-Gm-Message-State: APuU4Z8KjQJpznXynTQ2xI9gyQLy60Km8dpZ3C+GJk8y9HEXWA4txKTB
 CT/g+EDuOhGDf528XrfVjo4fAaja9FWg3JzobYfgBINLbUySt14qEao=
X-Gm-Gg: AYBFou3AKv5RUBriNU2osGqg/WontMe7cu25WNXCerZOCbTYskMmxZs5P6nOepk7EuG
 PY7CXp3cMAdGDw58oiAGaHneuSBYYa3NPb5yGRNRsRfygSEN1RHxF8aeKkMI5d1AkmnV90pubJm
 V4kAwkMZouLhFe4dyNmWR7zwXlprgABbVjbGKF1yA2S7LNZdiEyaMF4+cKFnd/n5tgGAQs6sS3T
 0JrSMswnNjvwFV2jA3u8uKBuO70CBwvDFYnKrvK7gSOJEMgwP+DpXr2IOz4zjzKq8O8Fz/064v2
 rL75p+yj6O16B/pUnNsMYiIVMRPqVtNkXW4LS2DRIrlAjnRT/ED2ItlAXMjHMy5mEQbnG2VehYd
 YoZq8+/2KnVDZ3++hi1u/zhNQ5UK+IRDk7cqVPAmiiaQ4zp88JHjx5TCrxHAT0nIWLpfwYnsxuD
 Q9d8gF2g8nhAt6RCFdFZ4KkGqs8UQPZVs8zRqI6YBOvLU/iZtZrdzNmr5HurHhiXMINp6iwI4AU
 VeiYQIfIXPRMm8jAhUrvx8h1s7RLXgWhJu44H2B1gNaaGhPqEx3P+6tmC3UIFuovyb79VBl5L6i
 cJLmUH9q6qaPn2QvwjUJvvz9PSds/wGcMCAMZ5FGErQaVlFgMwu9JBWZBUA+g56yzTkfMmgNU+D
 u2EPx+w39
X-Received: by 2002:a17:906:7309:b0:c46:645f:cedd with SMTP id
 a640c23a62f3a-c4ca7a18e93mr1175687766b.8.1793715896002; 
 Tue, 03 Nov 2026 06:24:56 -0800 (PST)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebf3cadbsm90903766b.50.2026.11.03.06.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 06:24:55 -0800 (PST)
Message-ID: <d4b18854-0e02-4fce-b168-d4e80035aaa8@gmail.com>
Date: Tue, 3 Nov 2026 15:24:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
To: rob.clark@oss.qualcomm.com, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-4-robin.clark@oss.qualcomm.com>
 <a4151c32-bac2-40ec-86f3-59d4dbfaae62@oss.qualcomm.com>
 <CACSVV02mTpCPZ-JtyYrsTEsRXKyS3zuxTehx=c91NbxgQSdpUQ@mail.gmail.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <CACSVV02mTpCPZ-JtyYrsTEsRXKyS3zuxTehx=c91NbxgQSdpUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 2:58 PM, Rob Clark wrote:
> On Tue, Nov 3, 2026 at 3:28 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 11/2/26 8:00 PM, Rob Clark wrote:
>>> We need to move the gpu lock around a bit for the next patch.  Use
>>> scoped_guard/etc so we don't have to make the error path handling more
>>> complicated.
>>>
>>> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
>>> ---
>>>   drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++-------------------
>>>   1 file changed, 12 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
>>> index f12701e286ec..aa59b28a3392 100644
>>> --- a/drivers/gpu/drm/msm/msm_debugfs.c
>>> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
>>> @@ -70,43 +70,36 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
>>>        struct drm_device *dev = inode->i_private;
>>>        struct msm_drm_private *priv = dev->dev_private;
>>>        struct msm_gpu *gpu = priv->gpu;
>>> -     struct msm_gpu_show_priv *show_priv;
>>>        int ret;
>>>
>>>        if (!gpu || !gpu->funcs->gpu_state_get)
>>>                return -ENODEV;
>>>
>>> -     show_priv = kmalloc_obj(*show_priv);
>>> +     struct msm_gpu_show_priv *show_priv __free(kfree)
>>> +             = kmalloc_obj(*show_priv);
>>>        if (!show_priv)
>>>                return -ENOMEM;
>>>
>>> -     ret = mutex_lock_interruptible(&gpu->lock);
>>> -     if (ret)
>>> -             goto free_priv;
>>> -
>>> -     pm_runtime_get_sync(&gpu->pdev->dev);
>>> -     msm_gpu_hw_init(gpu);
>>> -     show_priv->state = gpu->funcs->gpu_state_get(gpu);
>>> -     pm_runtime_put_sync(&gpu->pdev->dev);
>>> -
>>> -     mutex_unlock(&gpu->lock);
>>> +     scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
>>> +             scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
>>> +                     msm_gpu_hw_init(gpu);
>>> +                     show_priv->state = gpu->funcs->gpu_state_get(gpu);
>>> +             }
>> My clanker tells me we can't grab the PM reference before a mutex,
>> as the recovery mechanism depends on the rpm count being appropriate
>> to let it drop it (and kill gx this way)
> Yeah, but we also can't do it in the other order, or more specifically
> disabling ifpc needs to come before gpu lock or it can deadlock with
> recovery.. but ifpc disable needs to be after runpm get.
>
> Re-working that ordering was the whole of introducing cleanup.h, to
> avoid the error path with mutex_lock_interruptible() after taking
> runpm
>
> I guess if you are hammering on debugfs while crashing the gpu, maybe
> the first recovery fails, and then a subsequent one eventually
> succeeds.
I guess it leads to a sort of deadlock scenario because the recovery 
path waits
for power to collapse, though it timeouts after one second.

After that hangcheck will have to trigger again so I guess the delay 
introduced
would be significant.

I really wish there was some better way of doing recovery that didn't 
rely on
the counbter having a known value.

>
> BR,
> -R


Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

