Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431C606A327
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UlOUlC7i;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxYlyboc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E14CB10E762;
	Tue, 24 Nov 2026 12:53:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FC010F570
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:53:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuK9i3541799
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MPxO224nq+KvKykF/wWrxYrFxgOetNz/Mb64w5OfDr8=; b=UlOUlC7i0kZZlrrz
 i4lBtntLwsPdXBH+TJ7Qz+SG0hLX5LWFKmgjV+OPTYjxMRHW0CfuBiLSm3sZ+vyp
 wgZ+OPMQqIOuDzBcwCvIa21Yz7BZZZHPIRS/LK24t8Va2lQHeiKnskUtCVXmvOlu
 HhbPCs2uvIjOfVOWt5BjjfpHLcdH/hRptwTIv0TVJe5x/ZZDnloXWpsE4CgdBwWN
 Jfq8fQSvROerrRuMdtDsQC8dce/axCO0VACrt5ViLoGQOLcI8MqOOHJZr/4O3/JW
 FWSMOgkRUcra4ObMgE+A/qGgZ70q2D8s/y2OI2oGXbW08XdwcFQLiTuLGUTbCmQB
 WoI1Ew==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rh9pt0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:53:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-386b8624cf7so4124178eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795524815; x=1796129615;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MPxO224nq+KvKykF/wWrxYrFxgOetNz/Mb64w5OfDr8=;
 b=bxYlybocH4nl5VVFxRB6w7gxX+IFSWscfjKzg5wDGlzX6+oO2RlUDyDCQEgjKah+gZ
 2dDSOwoM3D176eZZ2jjMhXT50gheOjTZpKx9qBCxRLrvzVC4zK524OGgz7+fqMn1IzLu
 7DQDcltw7lApO9aUkxHH13RkvV0v3/xYwpDZb1qZHBWNM9fBoFzV2OEH4TYWX0tbVj7f
 kekVh8C3sl7HhKZtbVAdn7FAzQ48qY76nSgL+bBSxYmMeqMEX6mAtDdjmhz7/oBVtKIp
 /ZyIWNuu9Oo280OQEjiRd1PwIxAlNqPcY0gBqDJghPbZUy0LerY5pRK1/3e4x7aPIaed
 gqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795524815; x=1796129615;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MPxO224nq+KvKykF/wWrxYrFxgOetNz/Mb64w5OfDr8=;
 b=GtdV0f2JfjDSeepPicwJyu87UYQFg2dDmCtdNrOfxpY5NdViQKMzdNyjGm/gVpFnZ0
 sGk4pwn98fkhoNMyOShqGWzihdY82tOCB/XCvYNf9JC6K3Fwc91xg99Gjp7DBR9MY4EV
 icQvijGK8coqTe04seYhKoxB/17aCqCICkd32jx8mLgVmUcJf1wjxJEP1t/2N+T2JEgP
 CioXecAXXMLSx4Fg5OWuK+SmDvehVo8KCASCdP130W/5EIKWNEIcIqcsqzm73klWxPpG
 xiGybT9Q2zd+nwg7L8qhz+FblwPr728y4faTkgvPU1bh91rMdZBugkZ7P/rQZzwyrfga
 Iwiw==
X-Gm-Message-State: APuU4Z9Z881an5J0zg1r+TFu1ZWPzLNxO/JXLO/pudN4NNGdumTMFhax
 LzLEI76HBw92/vTWzVvXukhuw53m/HPyKmOsMrfPtQdRwKaA5ul6MoBjkSme8BG+tXfRLKIzZ/T
 LW2gkLrbBud6ayNEc0uJ8ayKdA9EpnShW5RNdgnuRvOMcunqEnswEMQDblP3T+YbUF432p2E=
X-Gm-Gg: AZFdTZfocx9QyNpiaSCjKkqgE1vyyH1EDY4FtK0Qh7GjXv6FFhfWS9P75NZVl55j5Ot
 +iSUEaZXx2Gr0nXQFw9uOfcF4Qd4I8bo7FKi+yqmCoMJrW4Ulin3UavP7EH15p2p4t4/THRQ4tV
 slQLaHK7uxKWKz07t8S8mZ0qWIlpxjDZCIDnAiN+CUzhcXcXzQtdyS9kvhNr8W7M9/gkWT6os5z
 6MHy2eX5rJmNwD/coqHc2XJwC4UMkNgKB8IOwikHD0hjqvkdrugljUjEs53zwsESvbaXQorRRJd
 XKQoV+fCS4VFU4Mtq8Rqo30h/T+taDLZFkPpcYeZNpO5EaXQUPXjkQOv+jSblDPFgs/WbHsskPB
 dnFTeQW0YOujAYeCaXSvNJbeRTE9OOOnxOpXRAaSBpnmXasl48pYN7vGw4TkSwqBX4+KejqKEHF
 Gg
X-Received: by 2002:a05:701b:450b:10b0:1b2:4e2e:d95a with SMTP id
 a92af1059eb24-1b55e06c4d7mr13012997c88.2.1795524815010; 
 Tue, 24 Nov 2026 04:53:35 -0800 (PST)
X-Received: by 2002:a05:701b:450b:10b0:1b2:4e2e:d95a with SMTP id
 a92af1059eb24-1b55e06c4d7mr13012974c88.2.1795524814348; 
 Tue, 24 Nov 2026 04:53:34 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b562a82b3fsm39113721c88.5.2026.11.24.04.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:53:33 -0800 (PST)
Date: Tue, 24 Nov 2026 18:23:29 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
Subject: Re: [PATCH v3 7/9] wifi: ath12k: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261124125329.7ppdthiyk3qj5azh@hu-mojha-hyd.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-8-mukesh.ojha@oss.qualcomm.com>
 <sashiko-outbox-219166@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-219166@kernel.org>
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b0588cf cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=nHrPeFJmhnP_XD_Sg_IA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MCBTYWx0ZWRfXxjP7cM5v1OLy
 UoCNoFKvKDbYLOc/vA2AtTRDA+NeV9+p9IzxHQnLKCmGYgwseKO55Ae5Kal4i6q28aVHMlRyqcr
 sUAyRj3k2GXC9E+e7ArV+Sv18VDs3tA=
X-Proofpoint-GUID: 1CFABl_VBLuTStYo6nDbaZtTkS8Nehph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MCBTYWx0ZWRfX9wR7xEmFrzYD
 lfOed7eC4jKS/7Jko3orV37HWHvn6XHNPwWi7XvlexmBYivAigOtgrx2LkfkDpyuJoun5CCCUv7
 ECNR2/OXLosnd/MH1o5J9HJGUrpbjk10HW1P/ZgeNl+W0HH8XowpSt2XeOX2Et+uWmC+4+gNMQb
 1JCoSSNcGmpkCH7VW2mXDvm/6WitDSSqUVnUNjiCjRAVOLWkcHa8PaF/KgXg3bCm9zUkk2pMOhf
 i8tPPQXU73huteYclM2DeONt1uXlKgWUWFqCxTdrMVR+ejtE1UnbzM49usuqkc84Xm+Bx5Kw9OS
 M7W4uH0Xglz5p8G8QZ9m+Z1RVj4ZEyzHNMMX2IrWrKFLyETMpsN9sh+9TphKXCQPyYxMToJ/JsT
 N5qGfxU1frIBjH2bw7J5xOrfSpI+J8EFOcOc/WAJWlzWe2Vlp61O77Zz7haCWKkEb1HGwRQVTae
 cLNb07164g1inWYx/PQ==
X-Proofpoint-ORIG-GUID: 1CFABl_VBLuTStYo6nDbaZtTkS8Nehph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240050
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 04:24:12PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] wifi: ath12k: PAS metadata leak in ath12k_ahb_power_up() and
>   shared FW load
> --
> 
> commit dad01e3cbb75f83eee2677fffc757868fad930d0
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> wifi: ath12k: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit replaces qcom_mdt_load() and qcom_pas_auth_and_reset() in
> ath12k_ahb_power_up() and ath12k_ahb_load_auth_shared_fw() with
> qcom_pas_context_init(), qcom_mdt_pas_load(), and
> qcom_pas_prepare_and_auth_reset().
> 
> > diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> > index 2c55aae06dd06..355f1f5509975 100644
> > --- a/drivers/net/wireless/ath/ath12k/ahb.c
> > +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> > @@ -411,6 +411,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
> >  	struct ath12k_ahb_rproc_info *rproc_info = ab_ahb->rproc_info;
> >  	char fw_name[ATH12K_USERPD_FW_NAME_LEN];
> >  	char fw2_name[ATH12K_USERPD_FW_NAME_LEN];
> > +	struct qcom_pas_context ctx;
> >  	struct device *dev = ab->dev;
> >  	const struct firmware *fw, *fw2;
> >  	unsigned long time_left;
> > @@ -444,14 +445,15 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
> >  		ATH12K_AHB_UPD_SWID;
> >  
> >  	/* Load FW image to a reserved memory location */
> > -	if (ab_ahb->scm_auth_enabled)
> > -		ret = qcom_mdt_load(dev, fw, fw_name, pasid, rproc_info->mem_region,
> > -				    rproc_info->mem_phys, rproc_info->mem_size,
> > -				    NULL);
> > -	else
> > +	if (ab_ahb->scm_auth_enabled) {
> > +		qcom_pas_context_init(&ctx, dev, pasid,
> > +				      rproc_info->mem_phys, rproc_info->mem_size);
> > +		ret = qcom_mdt_pas_load(&ctx, fw, fw_name, NULL);
> > +	} else {
> >  		ret = qcom_mdt_load_no_init(dev, fw, fw_name, rproc_info->mem_region,
> >  					    rproc_info->mem_phys, rproc_info->mem_size,
> >  					    NULL);
> > +	}
> >  	if (ret) {
> >  		ath12k_err(ab, "Failed to load MDT segments: %d\n", ret);
> >  		goto err_fw;
> > @@ -485,7 +487,7 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
> >  
> >  	if (ab_ahb->scm_auth_enabled) {
> >  		/* Authenticate FW image using peripheral ID */
> > -		ret = qcom_pas_auth_and_reset(pasid);
> > +		ret = qcom_pas_prepare_and_auth_reset(&ctx);
> >  		if (ret) {
> >  			ath12k_err(ab, "failed to boot the remote processor %d\n", ret);
> >  			goto err_fw2;
> > @@ -1023,6 +1025,7 @@ static int ath12k_ahb_load_auth_shared_fw(struct ath12k_base *ab,
> >  					  struct ath12k_ahb_rproc_info *rproc_info,
> >  					  const char *fw_name, u32 pasid)
> >  {
> > +	struct qcom_pas_context ctx;
> >  	int ret;
> >  
> >  	const struct firmware *fw __free(firmware) = NULL;
> > @@ -1041,14 +1044,16 @@ static int ath12k_ahb_load_auth_shared_fw(struct ath12k_base *ab,
> >  	ath12k_dbg(ab, ATH12K_DBG_AHB, "loading firmware %s, size %zd\n", fw_name,
> >  		   fw->size);
> >  
> > -	ret = qcom_mdt_load(ab->dev, fw, fw_name, pasid, rproc_info->mem_region,
> > -			    rproc_info->mem_phys, rproc_info->mem_size, NULL);
> > +	qcom_pas_context_init(&ctx, ab->dev, pasid,
> > +			      rproc_info->mem_phys, rproc_info->mem_size);
> > +
> > +	ret = qcom_mdt_pas_load(&ctx, fw, fw_name, NULL);
> >  	if (ret) {
> >  		ath12k_err(ab, "failed to load RO firmware %s: %d\n", fw_name, ret);
> >  		return ret;
> >  	}
> >  
> > -	ret = qcom_pas_auth_and_reset(pasid);
> > +	ret = qcom_pas_prepare_and_auth_reset(&ctx);
> >  	if (ret)
> >  		ath12k_err(ab, "failed to authenticate and boot shared firmware: %d\n",
> >  			   ret);
> 
> [Severity: High]
> Does this leak the PAS metadata buffer stored in ctx.ptr in both
> ath12k_ahb_power_up() and ath12k_ahb_load_auth_shared_fw()?
> 
> Previously, qcom_mdt_load() passed a NULL context pointer to
> __qcom_mdt_pas_init() -> qcom_pas_init_image(), which caused the backend
> to free the metadata buffer immediately.  qcom_mdt_pas_load() instead
> passes &ctx to qcom_pas_init_image(), which retains the allocated
> metadata buffer in ctx.ptr:
> 
> drivers/firmware/qcom/qcom_scm.c:qcom_scm_pas_init_image() {
>     ...
> 	if (ret < 0 || !ctx) {
> 		dma_free_coherent(dev, size, mdata_buf, mdata_phys);
> 	} else if (ctx) {
> 		ctx->ptr = mdata_buf;
> 		ctx->phys = mdata_phys;
> 		ctx->size = size;
> 	}
>     ...
> }
> 
> Neither qcom_mdt_pas_load() nor qcom_pas_prepare_and_auth_reset() frees
> this allocation, so ctx goes out of scope and leaks the metadata memory
> on every firmware load and error unwind path unless
> qcom_pas_metadata_release(&ctx) is called.


change https://lore.kernel.org/all/20260925165231.10722-1-mukesh.ojha@oss.qualcomm.com/
takes care of this is present in linux-next.
Please check the commit before trying to raise this point.


> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com?part=7

-- 
-Mukesh Ojha
