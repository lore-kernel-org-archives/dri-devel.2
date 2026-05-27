Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB33CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 20:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B2710E9EC;
	Wed, 27 May 2026 20:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sDv8zaE0";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A45310E9EC
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:43:40 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ba3e3c4f87so126275455ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779914620; x=1780519420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FXTPczjLvJobFRbkK7xxt7iJVHks66505vqIfh89VkA=;
 b=sDv8zaE0McqUuZPw4+2USNRqPLT1VGXmlOfydrBVyMsZebIL0zCzCvc1o+PyRNOWvZ
 9QtjL5r8kymV9YTL8yKV61kKNJhiZvniaFFk37m2RXze/yzI1DonlKPhzzCQh1pM1iUM
 xDL431/Vo7jjaa3CH8qWBjsQnD7BaXbkmuLkG873o8BmWtO3GlA4ZecrXduxC19Gzh0C
 VOZl03JEPPTicc5Dkti2xMWysStzG8FmiSnLHDU4E3EDxSeU5Y+cdGqwR0xDR3PouyvE
 U2pPWwtFZprC0vIjNOOhBovZFbln+TfkjDpau372103/eDcwEOlEkEbvuh76dZ09GpD+
 FTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779914620; x=1780519420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FXTPczjLvJobFRbkK7xxt7iJVHks66505vqIfh89VkA=;
 b=gUPDziYmWv4+IC6niLJqKUL3lDuTI5NA8uZggB8MKStqAa0r4ULMkL0I5Fsu8P0VBj
 m8iLTH/4wSI19nb8vvGAl5Oqx5cKMN2u3pavXPwDjTRBHdi6fcjyXH1/GchVgp0xibov
 6+PTK80/kdnLS0GM9Q/v4aOPvjAVYhyk6u7l9QKvmR4y/rPIP53LirUHkaS9i+9qVKz+
 ZYOWIm02r9UR/lvBdCJ2mqV7hLLFonfJbUeWkV9Hpxofivw5je6hR1aKpT4ZnG7Wv/Aa
 Pv0vbPKMHmzlC76OSZl2Ubat/GxFzvgLJBDauZox2n5asGsD6cipgkh1JPplEOJSpOjS
 mCdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/m9s+eShmrEC1hp34g8kBRbWn1298EztQRJajTckJKdjdKuFZqQtnf3vcrEKyXIUI6WSmu4FJF5s8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/Dhae4vdB+1SZN9bZY+VcTLJzUF2vRRfBiJEY4cyBuUhHNFg2
 zdTqsdhZ9hwCk5G8FesFn3CUnBcvjdvDwrLRurlivsTw5akNOpXcM3pi
X-Gm-Gg: Acq92OEoGnBerWzQi5uyHskpIek2wJnsByUsSDs73i2BmYJzqeS+5vxwBo4BJwrH553
 +0mhqz+DTwifoSLxIAQyybSeVRSRJzLPaj0sPfZBrt7foY1LyEFLtfZqtj6a+rnlYvf/A3AAGgH
 5VUknO+ZRxIVk/fvckUNtZyeg+yGvnGYtAReMEU0Z7oRYFU1kPJwr8v5YglToVlvaUeDVPb3Z9s
 F3yy0NCBF4gUHOxwLqHbeVWUD750kcR68sYFIqMR4+neW5Q+WVg6Je5+CiHPOx1QcT7DUWa9vgO
 U/I/DUBf04gMJoLrIpOl7Mb2qbJa8h+r19OIWPPAa2R7iBSmEL0Usdo3KkmRYez3ScAtm0xmW9Z
 4QVHwyLkQ2vbWQknuDfQcE1E19ShUiPJygLMaPbJ7MSIvgnCYyIExRhsWCLs543RCJ+pymfaXLg
 YoxdkIambdPqcbg1fCc1+Ih1+54i7WPiKSgH5tOGe+cjhU4+U=
X-Received: by 2002:a17:903:f86:b0:2bd:2de3:5198 with SMTP id
 d9443c01a7336-2beb033f48cmr279229085ad.3.1779914619757; 
 Wed, 27 May 2026 13:43:39 -0700 (PDT)
Received: from [172.18.227.108] ([219.88.198.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b2ccbsm165239385ad.48.2026.05.27.13.43.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 13:43:39 -0700 (PDT)
Message-ID: <30edf212-f656-4c09-a066-d765debf3fcb@gmail.com>
Date: Thu, 28 May 2026 08:43:31 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] arm64: qcom: Enable additional hardware on Radxa
 Dragon Q6A
To: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, neil.armstrong@linaro.org
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
 <20260522101323.31911-1-graham.oconnor@gmail.com>
 <15015D7EB84640D6+cc21a9f7-ae1b-4a22-bb38-34d6fafe1bcb@radxa.com>
Content-Language: en-GB, en-US
From: Gekko <graham.oconnor@gmail.com>
In-Reply-To: <15015D7EB84640D6+cc21a9f7-ae1b-4a22-bb38-34d6fafe1bcb@radxa.com>
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

Hi Xilin,

Thank you for the response.

I appreciate the offer to take over your patch set to move things 
forward. However, I feel I must respectfully decline. This is mainly due 
to my lack of experience with both upstream kernel development on this 
hardware and the patch management process itself. It would be 
irresponsible of me to take on something that I'm not knowledgeable 
enough to ensure successful completion.

I'm happy to work with you to help in any other way that I can such as 
testing patches, but I think you should maintain ownership of the 
patch-set and submission process, at least for now.

One of the reasons I withdrew my own patch-set is that from what I can 
see your series covers everything I was trying to achieve, and does it 
correctly :-)

The only one that isn't covered is the patch for early TCS 
initialisation that I'm discussing with Konrad which may be unnecessary 
anyway.

Graham

On 24/05/2026 13:58, Xilin Wu wrote:
> On 5/22/2026 6:13 PM, Graham O'Connor wrote:
>> Thank you to Konrad, Neil, and others for the very prompt and helpful 
>> reviews.
>>
>> Based on the feedback received, I think it best to withdraw this 
>> series to
>> address the issues raised, most notobly:
>>
>> 1. The DP_TRAIN_LEVEL_MAX change (patch 3) is too broad - it affects all
>>     devices using the Qualcomm MSM DP driver rather than being 
>> specific to
>>     the RA620 bridge. A proper fix should be implemented at the bridge
>>     level. This is going to take more investigation.
>>
>> 2. The display DT nodes (patch 5) should use the radxa,ra620 compatible
>>     string per the existing Radxa upstream series from Xilin Wu, and the
>>     lane ordering needs correcting.
>>
>> 3. The rpmh-rsc early return (patch 1) needs further review regarding
>>     the implications of returning before full driver initialization.
>>
>> 4. DTS patch label dependency issue (sorry)
>>
>> I'll integrate with the Radxa upstream effort, re-evaluate the other 
>> areas
>> and resubmit corrected patches addressing these concerns at a later date.
>>
>> Thanks for the feedback.
>>
>> Cheers
>>
>> Graham
> 
> Hi Graham,
> 
> Thanks for working on the additional hardware bring-up for Q6A upstream 
> support. I'm really glad to see someone pushing this forward.
> 
> I actually posted a patch series [1] last month, and it is generally in 
> good shape. Unfortunately, I got busy with other work and haven't had a 
> chance to send v2 yet.
> 
> If it helps, please feel free to take over that series and fold your 
> additional patches into it. I think that would be a good way to move 
> things forward.
> 
> Also, I believe patches 10-12 in my series are no longer needed and can 
> be dropped.
> 
> Thank you again for the work you have done.
> 
> [1] https://patchwork.kernel.org/project/linux-arm-msm/list/? 
> series=1078242&state=%2A&archive=both
> 

