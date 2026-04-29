Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F02FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:25:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CD2010E205;
	Wed, 29 Apr 2026 13:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQYPFip/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A0YMDKTG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018FF10F00E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:25:30 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T8pqhm1641544
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tESQm7/a22Cxh8QWHH7UiC0w
 dXJ6q1GIcYXgrhUKjnI=; b=DQYPFip/26hMD9exGNiQGhlON3S2bUV+8JfEYY9J
 Zx8ygITz/GtbM469Eq0PdgOS2noAWfj2Sra+9IJKYoatpUNmxT2vk/EsA/zewz2f
 THlpaOd9s5w5FK9gJadkUJhwBybrPpVTrPDBCChPn7ppTjgtxcjVg7F8obba83nV
 77cLKYPNgxlpc8k8OudwNa5NpdrfDgrI5yeoXlvjSJLCFfJIU7YcMa5bLJmoW2Sg
 ia/16AVPOY++1fIkbEzclcTHiZgEntPqkZ4Rh5OYP7CsqWjZ1Jx7GfTpA57LYOOx
 LUXrkAuHeqmYafFkaYwgBfiYgxjLHaEybXL/AE//v8vRBA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj81pe4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:25:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a90510a6d1so6688275ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777469129; x=1778073929;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tESQm7/a22Cxh8QWHH7UiC0wdXJ6q1GIcYXgrhUKjnI=;
 b=A0YMDKTGP/vQLjo0CnnrqtiYcVhSGWxLe7wKzPNTBHwnVNPI4myu1hbt8TEqk0sKat
 WoXSwDTYxIzcfNR+XRWdzRz/Ib5QuTMi21OORpgCblb21/yvLz+OKCi10uqeyWGEuKGb
 uSyJv9PwDfWrDGmn5cPPKV+UPiTYETUJfOBBeVeNKFymNGlO9+wImGH7II4Z4Gk264YL
 dEfwgF70esQVWTAFu1+Td8Ielqc9RFEf39OfB5ds7Ko0ukGUAEx/MPs3Jd8B9RntUK0f
 uoHgl0/SI4gB3wRE3usLA4oxa3lggpgGBdejJENdUQiMbWl3k9tPL7Gfsdi4IBT0Hrzk
 KwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777469129; x=1778073929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tESQm7/a22Cxh8QWHH7UiC0wdXJ6q1GIcYXgrhUKjnI=;
 b=Bf3aNuaTJwmcHiR40cQizV7J4jrhK4Xat2zoN8mKXVVw7Wb89WNTxN/qyepc6oeKRR
 O5L1fiGoRlcjbPbXICVk2QzgOQcnpjexjbNrebo9Ny7qfDGj5Sh+8CqshLyoTewvNHjm
 kzlmeQygQg/meTzra2mEcmU4rPbPnYQ3dFLeddsHDJEflep7oQ6htc4bJTYuU+cPTRmf
 vbHI2eQlzjziY1BDCf4C/nB4ttvQkyHe48RwyM+3cEYTXFqib65HgNjCTNCUtwO6ZFHQ
 JDeuIAGpvfdjL508brovdllfdfldiqEb7gvJmyZYTpmNo/C9dIMqpouCaH2wK4MqNvJg
 4FKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JQtXznjI7jaAbnrfFu1KK0kg/W3DJvk0IOCWNV3awJRPaAThWI/yyoz2CoFtrYnlfwYNXFPzKxNw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgVknulVoGQn2c/EFCI6chsedqefsrXCodS0YD/Lj5t2pRsrKE
 TXgb89le3gBBsnaRY39A4F7T2GggZ2XpBG/orBPPUtL2zuclAcf7mvmkZrOXzzGSGFHQK1MYBRZ
 y7YIbRCeM+NS2Q9lu3U642uVO9hi+ZHRbRtRbviheBxxukb8Smbvo5IWi4rDbmpY71lDi+oA=
X-Gm-Gg: AeBDietLFqVqMsGWQVqmR+QLLJyzbBve3Xvf/RFI3aj/NRvfDRMYFEFdjbuZT+Vf9fy
 w78Up8p3hIP20vNNYV6X6BaFKI1S4DYV2CIgU5i86KhsY/u/NyA/exxS3YOZtqwCCOOzDhhDhPa
 U1gOPn8d7ZojFihYvGlELNa/gYbG43v7Pzwxb21o+ZowVlGpR0PjdvU9l9mzqyAyMyGSLC4R5vN
 X6Mfcia/jBIyUnmewhzUMrTwFDo2q6o0TLIa6XXxB60mnMepZiLl/gIcTGS0pUyRcNOGQLF7JP6
 TthpX85/mdEzzVwBSI9ohcpOpQugq1evGsTNgQGjFspMl360Qy8IXB2TQ1x195tmmzCmNpRAiPm
 ig53E9+RzKoJcJk2ffxXenMs8lmFQTqykgu5AQLA7fXDuMKm4Y+Uurd0MQTw=
X-Received: by 2002:a17:902:ef06:b0:2b9:6cde:c345 with SMTP id
 d9443c01a7336-2b98823923cmr28867015ad.18.1777469128662; 
 Wed, 29 Apr 2026 06:25:28 -0700 (PDT)
X-Received: by 2002:a17:902:ef06:b0:2b9:6cde:c345 with SMTP id
 d9443c01a7336-2b98823923cmr28866375ad.18.1777469128039; 
 Wed, 29 Apr 2026 06:25:28 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98893f4e7sm24343015ad.39.2026.04.29.06.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:25:27 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:55:12 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 05/15] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
Message-ID: <20260429132512.aki4vqkhpil7awc3@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-6-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-6-sumit.garg@kernel.org>
X-Proofpoint-ORIG-GUID: V8jZrfo1ywqOwKube1hhrIn9H-Xbc3k9
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f206c9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=OiisSXWjcB2wRZQgg0QA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: V8jZrfo1ywqOwKube1hhrIn9H-Xbc3k9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNiBTYWx0ZWRfX4TkURAKlG9jz
 MZ6bDAI1iC20OPjTK4ViOwslk2rKKNahg98XmOPo3d81ggQRxjCP8a+8qahXL73bpsS94Wl986W
 RovwmrozVPnj03F9KdPvQu8Fngn/O+R84NgYp0GnHw7bxbmASt08t6K2ZTK6hKSrsY6Xno0wpge
 6l+FdQH6POdZHEFDIcDD/D2r/UGShcMSMOdBsk6cP8oGudEPnUDmGydiktAXVinfyNHRHu1ZPof
 qQ5EdsoIDPjSc0YbPwf8dQIyph9LIkGEvwDbdsncRDGvKXoHB2QY1LKGgqXtDikOPw/OzOsKMBd
 risIwvw6HmGdH2TfXj7K+kSd7//H7usElvUsBh9KluIvHAqiLKhiV//HDQ0XM3be0SuGqWPWACf
 rvdAxsAMZ80hModiwZ1W3Lgz2SDEPczexpdBPCj8nxUfQbaT8oBJHMi/PmeDtJQDupn9KqjZtkk
 s5AgOOhRw27iYvLSegw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290136
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

On Mon, Apr 27, 2026 at 03:25:53PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 51 +++++++++++++++---------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index da27d1d3c9da..847249c28c1b 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

Can you check do we really need this header ?

>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
> @@ -118,8 +119,8 @@ struct qcom_pas {
>  	struct qcom_rproc_ssr ssr_subdev;
>  	struct qcom_sysmon *sysmon;
>  
> -	struct qcom_scm_pas_context *pas_ctx;
> -	struct qcom_scm_pas_context *dtb_pas_ctx;
> +	struct qcom_pas_context *pas_ctx;
> +	struct qcom_pas_context *dtb_pas_ctx;
>  };
>  
>  static void qcom_pas_segment_dump(struct rproc *rproc,
> @@ -196,7 +197,7 @@ static int qcom_pas_shutdown_poll_decrypt(struct qcom_pas *pas)
>  
>  	do {
>  		msleep(QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS);
> -		ret = qcom_scm_pas_shutdown(pas->pas_id);
> +		ret = qcom_pas_shutdown(pas->pas_id);
>  	} while (ret == -EINVAL && --retry_num);
>  
>  	return ret;
> @@ -212,9 +213,9 @@ static int qcom_pas_unprepare(struct rproc *rproc)
>  	 * auth_and_reset() was successful, but in other cases clean it up
>  	 * here.
>  	 */
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  	return 0;
>  }
> @@ -228,9 +229,9 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
>  	pas->firmware = fw;
>  
>  	if (pas->lite_pas_id)
> -		qcom_scm_pas_shutdown(pas->lite_pas_id);
> +		qcom_pas_shutdown(pas->lite_pas_id);
>  	if (pas->lite_dtb_pas_id)
> -		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
> +		qcom_pas_shutdown(pas->lite_dtb_pas_id);
>  
>  	if (pas->dtb_pas_id) {
>  		ret = request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, pas->dev);
> @@ -250,7 +251,7 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
>  	return 0;
>  
>  release_dtb_metadata:
> -	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +	qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  	release_firmware(pas->dtb_firmware);
>  
>  	return ret;
> @@ -310,7 +311,7 @@ static int qcom_pas_start(struct rproc *rproc)
>  		if (ret)
>  			goto disable_px_supply;
>  
> -		ret = qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
> +		ret = qcom_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
>  		if (ret) {
>  			dev_err(pas->dev,
>  				"failed to authenticate dtb image and release reset\n");
> @@ -329,7 +330,7 @@ static int qcom_pas_start(struct rproc *rproc)
>  	if (ret)
>  		goto release_pas_metadata;
>  
> -	ret = qcom_scm_pas_prepare_and_auth_reset(pas->pas_ctx);
> +	ret = qcom_pas_prepare_and_auth_reset(pas->pas_ctx);
>  	if (ret) {
>  		dev_err(pas->dev,
>  			"failed to authenticate image and release reset\n");
> @@ -339,13 +340,13 @@ static int qcom_pas_start(struct rproc *rproc)
>  	ret = qcom_q6v5_wait_for_start(&pas->q6v5, msecs_to_jiffies(5000));
>  	if (ret == -ETIMEDOUT) {
>  		dev_err(pas->dev, "start timed out\n");
> -		qcom_scm_pas_shutdown(pas->pas_id);
> +		qcom_pas_shutdown(pas->pas_id);
>  		goto unmap_carveout;
>  	}
>  
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  	/* firmware is used to pass reference from qcom_pas_start(), drop it now */
>  	pas->firmware = NULL;
> @@ -355,9 +356,9 @@ static int qcom_pas_start(struct rproc *rproc)
>  unmap_carveout:
>  	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
>  release_pas_metadata:
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  unmap_dtb_carveout:
>  	if (pas->dtb_pas_id)
> @@ -406,7 +407,7 @@ static int qcom_pas_stop(struct rproc *rproc)
>  	if (ret == -ETIMEDOUT)
>  		dev_err(pas->dev, "timed out on wait\n");
>  
> -	ret = qcom_scm_pas_shutdown(pas->pas_id);
> +	ret = qcom_pas_shutdown(pas->pas_id);
>  	if (ret && pas->decrypt_shutdown)
>  		ret = qcom_pas_shutdown_poll_decrypt(pas);
>  
> @@ -414,7 +415,7 @@ static int qcom_pas_stop(struct rproc *rproc)
>  		dev_err(pas->dev, "failed to shutdown: %d\n", ret);
>  
>  	if (pas->dtb_pas_id) {
> -		ret = qcom_scm_pas_shutdown(pas->dtb_pas_id);
> +		ret = qcom_pas_shutdown(pas->dtb_pas_id);
>  		if (ret)
>  			dev_err(pas->dev, "failed to shutdown dtb: %d\n", ret);
>  
> @@ -484,11 +485,11 @@ static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *f
>  	 *
>  	 * Here, we call rproc_elf_load_rsc_table() to check firmware binary has resources
>  	 * or not and if it is not having then we pass NULL and zero as input resource
> -	 * table pointer and size respectively to the argument of qcom_scm_pas_get_rsc_table()
> +	 * table pointer and size respectively to the argument of qcom_pas_get_rsc_table()
>  	 * and this is even true for Qualcomm remote processor who does follow remoteproc
>  	 * framework.
>  	 */
> -	output_rt = qcom_scm_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
> +	output_rt = qcom_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
>  	ret = IS_ERR(output_rt) ? PTR_ERR(output_rt) : 0;
>  	if (ret) {
>  		dev_err(pas->dev, "Error in getting resource table: %d\n", ret);
> @@ -746,7 +747,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	if (!qcom_scm_is_available())
> +	if (!qcom_pas_is_available())
>  		return -EPROBE_DEFER;
>  
>  	fw_name = desc->firmware_name;
> @@ -838,16 +839,16 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  
>  	qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
>  
> -	pas->pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->pas_id,
> -						       pas->mem_phys, pas->mem_size);
> +	pas->pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->pas_id,
> +						   pas->mem_phys, pas->mem_size);
>  	if (IS_ERR(pas->pas_ctx)) {
>  		ret = PTR_ERR(pas->pas_ctx);
>  		goto remove_ssr_sysmon;
>  	}
>  
> -	pas->dtb_pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> -							   pas->dtb_mem_phys,
> -							   pas->dtb_mem_size);
> +	pas->dtb_pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> +						       pas->dtb_mem_phys,
> +						       pas->dtb_mem_size);
>  	if (IS_ERR(pas->dtb_pas_ctx)) {
>  		ret = PTR_ERR(pas->dtb_pas_ctx);
>  		goto remove_ssr_sysmon;
> -- 
> 2.51.0
> 

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
-- 
-Mukesh Ojha
