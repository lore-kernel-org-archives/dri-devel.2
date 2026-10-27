Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05D606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=NziVwBQg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B14110F43B;
	Tue, 27 Oct 2026 12:49:14 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA6A10F43B
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:49:09 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-93efc0452b5so267987785a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ieee.org; s=google; t=1793105348; x=1793710148; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Fk4tWvtlQqWKIFqJ5KSuzG0MEcWeW6IEPLtAR2pn3Ag=;
 b=NziVwBQgCX2J1wjFYCVpCGgESMNOCLQ0WJtgMj2ii+xvxsWEM5/009llfvNqQLllMA
 SuWYcorAEW1aJ+FBuAxoPXHucEdAlq0Sii6m4kT8XWtaxhoqo6o6KoLwzxjD7mX14UVK
 CHblYk4YSaY4gtkit1MZbbL/8phHQ9kC20eog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793105348; x=1793710148;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fk4tWvtlQqWKIFqJ5KSuzG0MEcWeW6IEPLtAR2pn3Ag=;
 b=bXH1TrOZRNFghMpz+NuYDUmfqHxvW9s8HXhYaGmhTG2xwTEvF7N3P9c2oO8sWoJcWs
 ZN9wO0d7iLfv4Mec9yVGYL3cVltmmHjOpzAvb0SJJMm+9shMIhRVmjGphDeuROXYOkBq
 zw8SbLCgxg5x9imhZjfCFC01knxwJlLHtBMb5ZweS4hgRPCoI9f9Z5/DBbk2Zwa4/0Xe
 Ri4ufX4xFVMvmU3Blw6AeW1qXGF61aGmDWDbxUg4Epc7fid3xlm9JVnxFnG+9pOd2UIv
 oedGrPhSMCFyyYvT4nqWC7PFP30xIWkoeno9xCxPD5u5+pewyp4eCeCOlQclLMTrglBy
 6pCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5Owhmrefh7Quvs6f3rUnSDLKxvDLQX/HRsFCmmGzWyD2yej3z5aQOYKJTNHwvsI3iflMY216uiZE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKKQx2K4T5i1coNvUmma4fYxYV/LFBHZUcAEzKYOKy9Cs3F5mgA
 aGXclfMywDfyKmNmu6RH/q+Vv/FluO0g+IsO2RGG2N4MOYUdxwBZkbll98Za81shxw==
X-Gm-Gg: AYBFou1PX7i7IGqlATNtFqbLmyvROFmiy5/THXN4KCHzyEVKYb0zvKqpsfTkTZq6F+I
 2I6Pl5jC3JIe+KmwZTJsnUKd39NezvoWg6T72itT1cQga5WLbdFMZqSRk7Dn1TqyatqOWMUFdr2
 ChrLydcvqSYdW0O67SBKt7K2pjj6L+VJxVMcz1ypuARMF4baRyeFaGh9D2Twx07foS5E3zCFU+y
 C0Vh/TOYqZUrzuO92GHvEQcjjQkqhjRNlXvBAt3Fkn/IetkdnXGrMwBBzCieXSVI84zqK/FDxIw
 F1hFc8j21feUakK/PutuOmjHPnH6roDFvnTWBbJFExsOVT5lQT9NFbnw8aBLWdz6us1eeFdQz6Y
 1jye4R8s95Jel7NEQeQhzOd4n0m5+uEUzn4uF5IDGFbWHlefqwtCreT3MU45BdGQPcUVkD84cMH
 t0rgvIyBZrdnRN2PsArLVxf3uvXH+3/2iLAoD5PUkyygTQWYF5nKnsCb+6ZD561azR6ALAN94yW
 pOTI17230BFe3JcbjZd+RKy8bodN8Z4rsrXLbYB1ofssF5W73w=
X-Received: by 2002:a05:620a:801c:b0:93e:7944:b874 with SMTP id
 af79cd13be357-940ef93a596mr1396495185a.33.1793105347945; 
 Tue, 27 Oct 2026 05:49:07 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-940f0a8549fsm956941085a.39.2026.10.27.05.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 05:49:06 -0700 (PDT)
Message-ID: <ccf0300c-80e8-41a5-a394-6ec55fddc913@ieee.org>
Date: Tue, 27 Oct 2026 07:49:03 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260925155737.4161358-6-mukesh.ojha@oss.qualcomm.com>
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/25/26 10:57 AM, Mukesh Ojha wrote:
> ipa_firmware_load() calls qcom_mdt_load() which bundles metadata init,
> memory setup, and segment loading with no PAS context, then calls
> qcom_pas_auth_and_reset() which skips the shmbridge prepare step required
> before TrustZone authentication.
> 
> Replace the open-coded memremap()/qcom_mdt_load()/memunmap() sequence
> with devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), then pass
> the same context to qcom_pas_prepare_and_auth_reset().
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

I think this does the right thing, however the IPA driver does
not use resource-managed (devm) interfaces, and this would be
a first.

Why does "qcom_pas.c" not offer an interface that can be used
without devm_kzalloc()?  What if someone wanted to pass in a
preallocated structure to be initialized with the (publicly
defined) PAS context?

I was going to suggest that you just rework the code to use
gotos and the cleanup path as used everywhere else in this
driver, but it looks like that's not easy.

I'm willing to ack this but I would have preferred to preserve
consistency.

Reluctantly:

Acked-by: Alex Elder <elder@riscstar.com>


> ---
>   drivers/net/ipa/ipa_main.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 14ac2d2faf7c..6964395caedd 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -585,12 +585,11 @@ static void ipa_deconfig(struct ipa *ipa)
>   
>   static int ipa_firmware_load(struct device *dev)
>   {
> +	struct qcom_pas_context *ctx;
>   	const struct firmware *fw;
>   	struct resource res;
>   	phys_addr_t phys;
>   	const char *path;
> -	ssize_t size;
> -	void *virt;
>   	int ret;
>   
>   	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> @@ -615,24 +614,23 @@ static int ipa_firmware_load(struct device *dev)
>   	}
>   
>   	phys = res.start;
> -	size = (size_t)resource_size(&res);
> -	virt = memremap(phys, size, MEMREMAP_WC);
> -	if (!virt) {
> -		dev_err(dev, "unable to remap firmware memory\n");
> -		ret = -ENOMEM;
> +	ctx = devm_qcom_pas_context_alloc(dev, IPA_PAS_ID, phys,
> +					  resource_size(&res));
> +	if (IS_ERR(ctx)) {
> +		ret = PTR_ERR(ctx);
>   		goto out_release_firmware;
>   	}
>   
> -	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> +	ret = qcom_mdt_pas_load(ctx, fw, path, NULL);
>   	if (ret) {
>   		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> -	} else {
> -		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> -		if (ret)
> -			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +		goto out_release_firmware;
>   	}
>   
> -	memunmap(virt);
> +	ret = qcom_pas_prepare_and_auth_reset(ctx);
> +	if (ret)
> +		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> +
>   out_release_firmware:
>   	release_firmware(fw);
>   

