Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39C60A2614
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PF2vfpno;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GuAjvzkd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBC2D10FF45;
	Wed, 18 Nov 2026 18:42:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB65910FF45
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:42:32 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHHMlp895283
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 supjWQ/8tiiTSWvb0f0hWdaRNkjBdKu9iua1cYtSbOQ=; b=PF2vfpno+jJczsL7
 gwxDfvPL6Vg5B+YBB+0F8c2Bzhw5hn2MV/goPaWvnBvL/EO20ThimukhQa8uD0B8
 WbSpY+rS8p1w90k8IZ1ChKYCMBe2kFk3cq/w0KRS2KxF85S3IU+7yzIC7bWy40PN
 VbcokZlfhyCcJloc/q5Z1QOdrYufuCIw5l/wHZwRaqon1y+LbO2kw3a2ZIuO4o7v
 xxT/20q3ma+12yYBTIfra6byFhzv8qeMv4dzBu0p7+P2aBvDEH7jlsY8uy9hpOjG
 B95Af4lBLF9opvLnE4r3CteQAwrA9gaajG2rjWQGN4ArzN71y6csCD8dl9T2B48p
 q9EYwA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9p0cw0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:42:31 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d2e7fa9fbbso76870137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795027351; x=1795632151;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=supjWQ/8tiiTSWvb0f0hWdaRNkjBdKu9iua1cYtSbOQ=;
 b=GuAjvzkdU0C+t1pHmnuRpKgyy6c0HnOtDEjyzJmYGXLnCCSHAk4jLjlnBfMlsCG1Gv
 Pwco1fRX2pV3A0NEI/tw5JKP3IWn3Wv2a0Zcs5lsSkh/aC9Zrbrexd1o3yhZ6wtktiso
 JoMLrBSjpu25hB8AgLDhUZcSkqVjaZikJ1WqQKvJ6XE9nrT2jPivPV17hHT/hIPvGeK2
 8Fg8US15hfwFeXZqzVvJwrkZbOvLWnEmEUlpmahsl0wUIT7TqFOzCFG/0VNq/U9BGkxp
 2fLYzDWO+i/jwSywzCFxVU+4IYuA1NVjygaRvme7aYtVw+ZLxB0GO/tBLjWtEJ0rqVqQ
 CLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027351; x=1795632151;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=supjWQ/8tiiTSWvb0f0hWdaRNkjBdKu9iua1cYtSbOQ=;
 b=mrxPZaTIK13YKLixkiRbOARO9rw4kAN4sldftRV6j7g3PnZH5jhSENkQXhrHHL4Rrg
 rMuUzlxPbcybcnHdg83Mcs4TMzYGKP0lzPUI1YRB+kX7h+7wmj1DFX9gaLatuXsBnGlK
 ekJO1YjsvCGoXKGkbu5nCJbDvOy2EnaiDiW4lUqrwnj4TaC0FsmNf0y9ad5RXL/W2Trh
 oxkQzc56ch43CWaSUuT136mxvf4iGUEjg4Ar17HDOnRZiNwD/pjABfNrqBaFmYdfi+qm
 DC9F494XkPyLL9XlhnaYMqC/W/7vJNfL7cpNch+HT3fsRm2hUejUk8C9wuPVEHKiSo01
 jwdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGIV1OOhZvjWRhGN9B90qdyqwXduKUmBf/E8zIASGuXl6HQMRrhGir7AqdHikfwBOtLCh1lOmSBaKk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9kmrRerRyiLx7BevwJHpL21nFT2KfyKDmZC7R8J+QIfunaijwh
 EX/qSy+zBncZcuHDaLJ8NCcXn+6qx50jFz+ZrhT9ku2IDxnUMHbMW+h0Ww1Os5BDlGguwwI1UmZ
 ZvgrZx/3o5pYcl/YvnNMdJgAtmPyvliCc9hiH7fTkBCKhHmgSgM/XnBK+5kBpWYWgKl9W9Io=
X-Gm-Gg: AYBFou3Xg6MktFIRMKnVkZot6e88s3Pb6c9NbjdnEO5TERH6BFqcKT/V3dvNn9XosE7
 NK2h8BX1QxtLDPC/hQ7P5eAHZyvYo9A5UHAEffElYT1vjDLBa0BaQOXmofVpbEIKBG4sCPwRjmL
 jj2NkUbRkJY57COSiejboh4fTA3WBA1XyAqgcYMOcJAR5pV/bqEEtvc53//HgQxZl87F9AG6jQV
 3VgjSpbf98h25MqRs8YcQWpeAtInn/SwdKIz89r36aPc9DJ+ODPRVt4YWXBXV+AU5iYmTNQBjSr
 oGNd89UZwQz99NoSqoTbqzzfZ12q+yUItsFWwBuFhqbnFwMDxghZZf221kb5p8wR+J6+CeMbGhg
 Nu40rk3GZr6mIowgfIAB/ZfhIB5jNC1v2Tcpg2qnb4Xl+9C78GXWvOr/zgevYYZvqw7X4+qHqMQ
 ==
X-Received: by 2002:a05:6102:442a:b0:7d2:d799:d7c2 with SMTP id
 ada2fe7eead31-7d6cb430827mr150827137.2.1795027350916; 
 Wed, 18 Nov 2026 10:42:30 -0800 (PST)
X-Received: by 2002:a05:6102:442a:b0:7d2:d799:d7c2 with SMTP id
 ada2fe7eead31-7d6cb430827mr150801137.2.1795027350370; 
 Wed, 18 Nov 2026 10:42:30 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6b91e87f4sm2532457137.7.2026.11.18.10.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 10:42:29 -0800 (PST)
Message-ID: <4d16306b-31c1-4406-a1f4-858abd3f44ff@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 00:12:18 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] firmware: qcom: scm: Add
 qcom_scm_gpu_init_regs_is_available()
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
 <20261118-adreno-scm-fallback-v1-1-e99cdbf3121d@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-1-e99cdbf3121d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: _eOIUcefcLLQO_RrZvJNF8KvFG-uFcIE
X-Authority-Analysis: v=2.4 cv=LooHWXdc c=1 sm=1 tr=0 ts=6afdf197 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=L50M_nCPciy2geT04tYA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX5kNwMSooRbO6
 9dtkcrcCFbDmpNDPdtlfaUdWIC+gS9J50ivv3rtJFp/rHjBgLKSbTST6rncIbMCWhnAa4AaYF/4
 swzkeGJLjWQA4fLcJxxkizy5e8eVi80yYoQfna5rkz695pG461zK7xAgNHcq1Ew+bI3hiEXdN6Q
 F7m75dzwudKFpTgEMSgY2EuudTgqfqBYrL+1YD70YTxiO2VeJ0UkzLeCGWtUcVNxp1KLf8kb4Am
 yEk3DJNuDUwiabu7l1ZLdZ3bjkQQ/IG3kvOdwwpdBEKg0XxqH1HTL1VW+1REsPYnwCQN93jOrEA
 XALHvKZ4cYWWI1YxGLBNn6xRhRg/x849DmfvOiDbMey2EHvlEs0TPo98fdBBGLrNhxVkhhgvp0K
 Nw3ImARABcMmw1BlfgMASbmM4btgfWo9RnB92cR+t7Q8HiJVS5wC3EhvRuXYcly37Gz1IeyWfU7
 IID0y7ZyqHHQr2mdBkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX7Rfca5GsOKOs
 PB0Cgp2ymOFT2ar83LLi5vMKOBCmNQAsDu7qy+xzWGDE+G6JskzhbkJyuXlmLDudOTR0kBcjXRW
 YpqcRM9W1FHs1290pjJTZS610afowKo=
X-Proofpoint-GUID: _eOIUcefcLLQO_RrZvJNF8KvFG-uFcIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
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
> The Adreno driver asks the secure world to initialize some GPU registers
> through qcom_scm_gpu_init_regs(), and fails to power up the GPU if this
> call fails.
> 
> Not every secure world implements this call. When it is missing, the
> call fails in the same way as a real error, so the driver cannot tell
> the two cases apart.
> 
> Add qcom_scm_gpu_init_regs_is_available(), similar to
> qcom_scm_set_gpu_smmu_aperture_is_available(), so that the driver can
> check whether the secure world supports the call before making it.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil> ---
>  drivers/firmware/qcom/qcom_scm.c       | 7 +++++++
>  include/linux/firmware/qcom/qcom_scm.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 030e4ba90812..f4f34b7dd0b2 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1941,6 +1941,13 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
>  
> +bool qcom_scm_gpu_init_regs_is_available(void)
> +{
> +	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_GPU,
> +					    QCOM_SCM_SVC_GPU_INIT_REGS);
> +}
> +EXPORT_SYMBOL_GPL(qcom_scm_gpu_init_regs_is_available);
> +
>  int qcom_scm_gpu_init_regs(u32 gpu_req)
>  {
>  	struct qcom_scm_desc desc = {
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> index a0a6bc0229c4..c9e88b2904e3 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -131,6 +131,7 @@ bool qcom_scm_lmh_dcvsh_available(void);
>   */
>  #define QCOM_SCM_GPU_TSENSE_EN_REQ BIT(3)
>  
> +bool qcom_scm_gpu_init_regs_is_available(void);
>  int qcom_scm_gpu_init_regs(u32 gpu_req);
>  
>  int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,
> 

