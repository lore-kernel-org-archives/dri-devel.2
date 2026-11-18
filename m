Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A300A606A33D
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ghAf1fWq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aP7ggoyd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1432C10FF50;
	Wed, 18 Nov 2026 18:48:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6962510FF50
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:48:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHGNfn2447575
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xVyCK/YjIK6m0DRrtbGLKt21hcD0fUBOxh9LryG5JHo=; b=ghAf1fWqlrIIZ/4c
 L5MqjIIqFYxZrDjkevbUzpzc4maUhdeNgniNyDVu3bnpFnIa2f9SVeZQOs8At975
 sOFp1Hz9K5Ca6OYe0sHTJoZP/cHYYdPZLg0D73Uue07kmT/MUuz6eB+pDe0g19Wp
 5DNQf+gA7E9wgv+KlAvphWd7h9UnmF0ONWnSCy0I4+9wx+F64L1e0lCG1myFKBhr
 o/vac1R880aCtHB+tl7rlR0wzIum19/3heW/IW5I8FcIQX8HgA9iUMxDmDlzK9Im
 ZNmFq8Bqrj9amDdIC+ZF6jfDw0z9sE5moptVroQ1u6yrQ63fFI8jEfiflQT6ZZpV
 J0SnZQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3b8fnd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:48:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso1554850c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795027693; x=1795632493;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xVyCK/YjIK6m0DRrtbGLKt21hcD0fUBOxh9LryG5JHo=;
 b=aP7ggoydF9CcNRCeYTMmaVdkQrrcog0y4Humh11fbAd6p4TUWnHmhaCPC1ugQFXUjS
 WXFw5kLVTFNbdpmOQeO9kvfwLER6M0ML5ZfNPLw0cGOl7OklAQSE0XX3uv/tDEcvVw+3
 zwqTNHXGo3Ah8UwP4KDWNszilA2A2CuabYczWVCdLWSiRPwmBU7tn8nzvXpEryEfBioj
 z7oS1Q7ml53F/sLLWr681vcKLYs6d/5Sqd6SKlVKkJ+PO1DjHvQ0OKiHugqdJvOcb75T
 kfa/coij0XUPKbr1oQdXGztbLcoXBwW+c/d4tIqCq01B3S1g1g2kwOpDLA0rJOL8jyZs
 V7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027693; x=1795632493;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xVyCK/YjIK6m0DRrtbGLKt21hcD0fUBOxh9LryG5JHo=;
 b=hdNrM5tx9HkBkfFm52YJflBDUM9a50afggV1z5EGCxCNZqrVJoU+DWDZi2dWRKaAHN
 dMv7ZWkq6x2wB5h9MBv6RZZ05O1z27xit8vYJOCcRC0CPQ28hYIO8krWCyhJD7MnxNWJ
 RnCYsvMwxNJfzBlNY+qKWTMT5FS6wUdok0BC5pf4xAT7UsGwIE1bzw9uZDJSX56sxkwt
 LC1bx3zex3MEPJ4KySJ7BTFuedRSGZOjLAgYvrVZ4H2ya57yUBu5Yhg3p8yb7U71Egov
 H7T0OorZh1QBkkH3ngpsRe2ZxywNVqA2RI8qDbcLYRrhHcVIEjGFtW3zhL0cvPvDJCVU
 gKpA==
X-Forwarded-Encrypted: i=1;
 AL+hErHBLLH/IwSj+cxHxpNBcHwX/fleH5U9KyumTPyYPFSwZLf5D0dQHfjFU/dq88XRDDBUYZ3TYP1qaeQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8BhxDV5Spq3vo13Yu0QRcVnwcV71PC4eC8Mfyc9DkH4ko3LGOj
 FuFnME8tbRnS7jIQKAEvvULxFI/1KBN5UbBqjCCJ1Ti9RvBHvGhWDNsnaTwKiMl+hqi1kkfCntg
 v8tiMlnUjTVwY0cArW0ZlKI11nrs/F5GXVnl7rTCheIOLtW9nD1IGufXzFybwSarsXGmAgFw=
X-Gm-Gg: AYBFou1pYh6eRJ/TMriIF41pFYJ1t23Zrhta02Yd0CN3MHUymy/TIHZfbeAaWWtU+B4
 hqnwL54ilq4vRkV0CoF7VDUeIF/QgsObw63XJw6UqKhub91tcIJQ9NmoAl996J3U1O/+Hc3hLm1
 HV9m9hHWjcY3K4oALxCUCePZZ21wNAwx0TU9aKq1xY3vsQF369sIIhq2pclP6+64NvIAHfGeGOP
 PMRYLFV+TZ1njsHnc+aBH6XSj1LAVh9A1JTit4xJA+Cxt1UPPdxNnFP9z5GW/+TZcC+VBhIvps1
 WrjeAgQB5EkkwQQk9SqdwMz+FB/5HWGMlP0Njy+EJSdasHXUb2R6V9keZM0KUWOPLGsNhuFvKYZ
 bxjU2dDopKx2iZtesJ5yZzOHNW+wg92KR9btkzkZqar3quOZSDuUfvY+eVEAWf6QRoKKzXqP2kQ
 ==
X-Received: by 2002:a05:7022:1408:b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b543d3cc31mr3070453c88.32.1795027692689; 
 Wed, 18 Nov 2026 10:48:12 -0800 (PST)
X-Received: by 2002:a05:7022:1408:b0:1b2:366a:e7d1 with SMTP id
 a92af1059eb24-1b543d3cc31mr3070416c88.32.1795027692068; 
 Wed, 18 Nov 2026 10:48:12 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447f4e19sm11777335c88.13.2026.11.18.10.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 10:48:11 -0800 (PST)
Message-ID: <d42b3653-e4b3-4a0c-814c-02ad511fdb85@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 00:18:03 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/msm/adreno: Program the SMMU aperture when the
 secure world can't
To: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
 <20261118-adreno-scm-fallback-v1-4-e99cdbf3121d@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-4-e99cdbf3121d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IHBDJ0GdJsFOSgqo79LNge7IO1ysCncV
X-Proofpoint-GUID: IHBDJ0GdJsFOSgqo79LNge7IO1ysCncV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfXyfmgpzVYl9tz
 KOScPgayb3ejzOn8+DOkVB48X3v7+RmOPn+kDPgfY4K8RY36DDMF0hfLHCvhvxK/lKwnWMKYnOO
 0mYfpp7UefvBz5XBFceZoHANLKqngJs=
X-Authority-Analysis: v=2.4 cv=dZQVTnXe c=1 sm=1 tr=0 ts=6afdf2ee cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=tbUVMzGWZ8bGTt1F5tgA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfXz2K2T6w8z1pc
 GeEexiZpa0h3r/5xkyFfzKKVuyLUf9hVt4q/tWQBynD+iP7NQKepLhHWXqOMwipD6QDYfXNHtJi
 M9AQOEGpPb1xg0ESqKQTDJABb4DqgajU8URXR2cnd/VbbOWcZKcyMtfhyDzUjgm0PY/u0QT2gOE
 NMiaeMj/9oC3VCHV1QqBZ0/8T4ibK97ZgWk5RrFz6jiZmjtjimtFPRbaffIN/MHSg06u8SeYsWb
 LrnqT4toD/fyujAi353VTJRSPGFjSNE1JNfcXrGm+K5zW3nCTOAoSq7ZnUGpnOcfikjtJ2D3k1H
 me7lwJTc0fqHKsz2oNMCuVjcf+1bcqjFqybmwfnRscw0PuUuHzhI/xG0wuE4EtVPEoV4PZbZLjD
 pB28vQyc7iMbo2/HxHsnh/esPdMaw3ttODEIR4EFOEDl9GPu8ce0xnrIDzyCjW8McrWy2SFIBOD
 SoAo22LT9wHZPUxqg5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180074
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/2026 6:38 PM, Puranam V G Tejaswi wrote:
> The CP switches pagetables by writing the GPU SMMU context bank
> registers itself. It reaches them through the CX SMMU aperture, a
> register block in the GPU, which has to point at context bank 0. The
> secure world normally owns this block and programs it when
> adreno_hw_init() calls qcom_scm_set_gpu_smmu_aperture().
> 
> Some platforms have a secure world that does not implement this. Nothing
> programs the aperture on these platforms, so the CP cannot switch
> pagetables.
> 
> If the SCM call is not supported, program the aperture from
> adreno_hw_init() instead. Point the GC aperture at context bank 0 and,
> on GPUs with LPAC, the LPAC aperture at context bank 1, the same way
> the secure world does. Disable the other apertures. The SCM call is
> still used whenever it is supported.
> 
> The values depend on where context bank 0 sits in the GPU register
> space, which differs between GPUs, so they come from a register list in
> the GPU catalog. The aperture region comes from DT. If DT describes the
> region but it cannot be mapped, fail probe. Add the lists for A702,
> whose entry Shikra's GPU also uses, and for A753.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c |  9 ++++++++
>  drivers/gpu/drm/msm/adreno/a7xx_catalog.c | 10 +++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c   | 37 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h   | 21 ++++++++++++++++++
>  4 files changed, 77 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 4ef2bd6e7ad2..fe1902b8de16 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -736,6 +736,14 @@ static const struct adreno_reglist a702_hwcg[] = {
>  	{}
>  };
>  
> +/* GPU aperture: GC to CB0, other apertures disabled */
> +static const struct adreno_reglist a702_aperture_reglist_regs[] = {
> +	{ 0x00, 0x000a8000 }, /* GC: CB0 */
> +	{ 0x08, 0x00000000 }, /* CTRL: GC only */

These offsets should be documented in the xml file instead of hardcoded values.
Otherwise LGTM.

-Akhil.
> +};
> +
> +DECLARE_ADRENO_REGPAIR_LIST(a702_aperture_reglist);
> +
>  static const struct adreno_info a6xx_gpus[] = {
>  	{
>  		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
> @@ -1198,6 +1206,7 @@ static const struct adreno_info a6xx_gpus[] = {
>  		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
>  		.funcs = &a6xx_gmuwrapper_funcs,
>  		.zapfw = "a702_zap.mbn",
> +		.aperture_reglist = &a702_aperture_reglist,
>  		.a6xx = &(const struct a6xx_info) {
>  			.hwcg = a702_hwcg,
>  			.protect = &a650_protect,
> diff --git a/drivers/gpu/drm/msm/adreno/a7xx_catalog.c b/drivers/gpu/drm/msm/adreno/a7xx_catalog.c
> index 9465ffa3dd12..43d681aa3c2e 100644
> --- a/drivers/gpu/drm/msm/adreno/a7xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a7xx_catalog.c
> @@ -279,6 +279,15 @@ static const struct adreno_reglist_pipe a7xx_dyn_pwrup_reglist_regs[] = {
>  
>  DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
>  
> +/* GPU aperture: GC to CB0, LPAC to CB1, other apertures disabled */
> +static const struct adreno_reglist a753_aperture_reglist_regs[] = {
> +	{ 0x00, 0x000c0000 }, /* GC: CB0 */
> +	{ 0x04, 0x000c1000 }, /* LPAC: CB1 */
> +	{ 0x08, 0x00000002 }, /* CTRL: GC and LPAC */
> +};
> +
> +DECLARE_ADRENO_REGPAIR_LIST(a753_aperture_reglist);
> +
>  static const struct adreno_info a7xx_gpus[] = {
>  	{
>  		.chip_ids = ADRENO_CHIP_IDS(0x07030001),
> @@ -465,6 +474,7 @@ static const struct adreno_info a7xx_gpus[] = {
>  			  ADRENO_QUIRK_PREEMPTION |
>  			  ADRENO_QUIRK_IFPC,
>  		.funcs = &a7xx_gpu_funcs,
> +		.aperture_reglist = &a753_aperture_reglist,
>  		.a6xx = &(const struct a6xx_info) {
>  			.protect = &a730_protect,
>  			.pwrup_reglist = &a7xx_pwrup_reglist,
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 54f337475231..c3c84629c5f4 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -675,6 +675,13 @@ int adreno_hw_init(struct msm_gpu *gpu)
>  		ret = qcom_scm_set_gpu_smmu_aperture(0);
>  		if (ret)
>  			DRM_DEV_ERROR(gpu->dev->dev, "unable to set SMMU aperture: %d\n", ret);
> +	} else if (adreno_gpu->aperture) {
> +		const struct adreno_regpair_list *list =
> +			adreno_gpu->info->aperture_reglist;
> +
> +		for (int i = 0; i < list->count; i++)
> +			writel(list->regs[i].value,
> +			       adreno_gpu->aperture + list->regs[i].offset);
>  	}
>  
>  	for (int i = 0; i < gpu->nr_rings; i++) {
> @@ -1193,6 +1200,32 @@ int adreno_read_speedbin(struct device *dev, u32 *speedbin)
>  	return nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
>  }
>  
> +/*
> + * Map the GPU aperture, so that adreno_hw_init() can program it when
> + * the secure world does not.
> + */
> +static int adreno_gpu_aperture_init(struct platform_device *pdev,
> +				    struct adreno_gpu *adreno_gpu)
> +{
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	if (!adreno_gpu->info->aperture_reglist)
> +		return 0;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aperture");
> +	if (!res)
> +		return 0;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	adreno_gpu->aperture = base;
> +
> +	return 0;
> +}
> +
>  int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  		struct adreno_gpu *adreno_gpu,
>  		const struct adreno_gpu_funcs *funcs, int nr_rings)
> @@ -1238,6 +1271,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  
>  	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
>  
> +	ret = adreno_gpu_aperture_init(pdev, adreno_gpu);
> +	if (ret)
> +		return ret;
> +
>  	adreno_gpu_config.nr_rings = nr_rings;
>  
>  	ret = adreno_get_pwrlevels(dev, gpu);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 2911d440ab17..021802c6830c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -88,6 +88,19 @@ struct adreno_reglist {
>  	u32 value;
>  };
>  
> +struct adreno_regpair_list {
> +	/** @regs: List of register offset and value pairs **/
> +	const struct adreno_reglist *regs;
> +	/** @count: Number of registers in the list **/
> +	u32 count;
> +};
> +
> +#define DECLARE_ADRENO_REGPAIR_LIST(name)	\
> +static const struct adreno_regpair_list name = {		\
> +	.regs = name ## _regs,				\
> +	.count = ARRAY_SIZE(name ## _regs),		\
> +}
> +
>  /* Reglist with pipe information */
>  struct adreno_reglist_pipe {
>  	u32 offset;
> @@ -129,6 +142,11 @@ struct adreno_info {
>  	 */
>  	struct adreno_speedbin *speedbins;
>  	u64 preempt_record_size;
> +	/**
> +	 * @aperture_reglist: Optional GPU aperture register values. Used if
> +	 * the secure world does not program the aperture.
> +	 */
> +	const struct adreno_regpair_list *aperture_reglist;
>  };
>  
>  #define ADRENO_CHIP_IDS(tbl...) (uint32_t[]) { tbl, 0 }
> @@ -250,6 +268,9 @@ struct adreno_gpu {
>  
>  	bool has_ray_tracing;
>  
> +	/* GPU aperture, if the driver may need to program it */
> +	void __iomem *aperture;
> +
>  	u64 uche_trap_base;
>  };
>  #define to_adreno_gpu(x) container_of(x, struct adreno_gpu, base)
> 

