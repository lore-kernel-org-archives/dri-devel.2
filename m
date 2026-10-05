Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6BBCA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF1FA10E273;
	Mon,  5 Oct 2026 13:48:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="NKHAyisg";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0AF4510E273
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:48:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C6C152B;
 Mon,  5 Oct 2026 06:48:12 -0700 (PDT)
Received: from [10.57.78.53] (unknown [10.57.78.53])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CA163F86F;
 Mon,  5 Oct 2026 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791208095; bh=2GMHsOwhhLRJxYzsvnSnRcaGszSH1LEMmm6JkzS5eLI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NKHAyisgoqP215hu3VhI99n9NoZqEksTsDpoR1M6QqOnSAsxFV5sJqYRRqXfQJKFi
 z7DLZqvvr1Qtb9j+rcNd1wPVHK/ycB+uk6PgEXqzIeRa80wb/Zk8VMY2syNmhr0KG1
 zQEcsMAW9YiB86qkK21wV2bcLqLCbS7TEAEC7D7Y=
Message-ID: <78190a05-47a6-4089-a688-121466c9a370@arm.com>
Date: Mon, 5 Oct 2026 14:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: add Mali-G68 support
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 markuss.broks@gmail.com
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260803-staging-mainline-v1-1-5071dc782149@gmail.com>
 <asA6VefBKQQD3eSH@sobremesa>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <asA6VefBKQQD3eSH@sobremesa>
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

On 03/10/2026 00:19, Adrián Larumbe wrote:
> Queued to drm-misc-next.
> 
> One thing though, I had to adjust the indentation of the GPU_REV() macro before merging.
> Not a big deal, but always make sure to run the following in your branch before submission:
> 
> ./scripts/checkpatch.pl --strict --git first_commit~..HEAD
> 
> Also, I suppose you didn't have a chance to test it on a g68_r1p0. That would be of interest
> because of HW_ISSUE_TTRX_3485, which seems to mandate the submission of a dummy job before
> any real further work. It seems at the moment there's no such a workaround either in the
> UM Mesa driver or the Panfrost KMD.
> 
> Maybe Steven or Boris could elaborate on this?

Yes, it's an unpleasant workaround. But it's also a rare issue. It
requires that the kernel driver decides to stop a fragment job at the
wrong moment when the fragment endpoint is first configured. The GPU can
then end up hanging[1]. The hardware r1p1 fixed the issue. I believe the
workaround is to submit a dummy fragment job after power up which
ensures that the fragment endpoint is configured before any real work
(which might need to be stopped) is submitted.

What I don't actually know is if anyone shipped a r1p0 implementation.
There were internal test chips, but many if not all customers jumped to
r1p1 where the fix is present.

If there are G68 r1p0s out in the wild then they will "mostly work".
It's hard to hit the issue accidentally. So there's definitely still
value in the support even without the workaround. But if anyone does
have a Mali-G68 r1p0 (that they are trying to use Panfrost on) then it
would be good to know.

Thanks,
Steve

[1] I believe the reset logic will then recover the GPU, but will lose
any in-flight work. So you'll get rendering errors for that frame, but
things should recover.

> On 03.08.2026 12:35, Markuss Broks via B4 Relay wrote:
>> From: Markuss Broks <markuss.broks@gmail.com>
>>
>> Add the features, issues, and ID for Mali-G68, a first-generation
>> (v9) Valhall GPU.
>> Tested on Exynos8835: the GPU reports GPU_ID 0x9204 (G68 r1p1).
>>
>> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
>> ---
>>  drivers/gpu/drm/panfrost/panfrost_features.h | 2 ++
>>  drivers/gpu/drm/panfrost/panfrost_gpu.c      | 3 +++
>>  drivers/gpu/drm/panfrost/panfrost_issues.h   | 8 ++++++++
>>  3 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_features.h b/drivers/gpu/drm/panfrost/panfrost_features.h
>> index 52f9d69f6db9..34c65847192f 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_features.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_features.h
>> @@ -121,6 +121,8 @@ enum panfrost_hw_feature {
>>  	BIT_ULL(HW_FEATURE_IDVS_GROUP_SIZE) | \
>>  	BIT_ULL(HW_FEATURE_CLEAN_ONLY_SAFE))
>>  
>> +#define hw_features_g68 hw_features_g57
>> +
>>  static inline bool panfrost_has_hw_feature(struct panfrost_device *pfdev,
>>  					   enum panfrost_hw_feature feat)
>>  {
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> index 7d555e63e21a..83223192a544 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
>> @@ -242,6 +242,9 @@ static const struct panfrost_model gpu_models[] = {
>>  	/* MediaTek MT8188 Mali-G57 MC3 */
>>  	GPU_MODEL(g57, 0x9093,
>>  		GPU_REV(g57, 0, 0)),
>> +
>> +	GPU_MODEL(g68, 0x9004,
>> +		GPU_REV(g68, 1, 0), GPU_REV(g68, 1, 1)),
>>  	{0},
>>  };
>>  
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_issues.h b/drivers/gpu/drm/panfrost/panfrost_issues.h
>> index eb60cb83667a..dd39946bb572 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_issues.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_issues.h
>> @@ -265,6 +265,14 @@ enum panfrost_hw_issue {
>>  #define hw_issues_g57_r0p0 (\
>>  	BIT_ULL(HW_ISSUE_TTRX_3485))
>>  
>> +#define hw_issues_g68 (\
>> +	BIT_ULL(HW_ISSUE_TTRX_2968_TTRX_3162))
>> +
>> +#define hw_issues_g68_r1p0 (\
>> +	BIT_ULL(HW_ISSUE_TTRX_3485))
>> +
>> +#define hw_issues_g68_r1p1 0
>> +
>>  static inline bool panfrost_has_hw_issue(const struct panfrost_device *pfdev,
>>  					 enum panfrost_hw_issue issue)
>>  {
>>
>> ---
>> base-commit: 415606a7be939835db9b0d6b711887586646346d
>> change-id: 20260803-staging-mainline-ebe89543b632
>>
>> Best regards,
>> --  
>> Markuss Broks <markuss.broks@gmail.com>
> 
> 
> 
> Adrian Larumbe

