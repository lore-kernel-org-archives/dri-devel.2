Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B70606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RLl4Uahc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MEICeAs3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44E910E84E;
	Tue, 24 Nov 2026 12:36:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 979BA10F562
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:36:03 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuhDK1291445
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 D+M9rlByaDbbaT9zq7kzAImNLpeGnWkyEswhM9oCd88=; b=RLl4Uahc1don/HYN
 Szg3CGFjyihWLYwDSuAvm4twEs8H5xariWDdPXZJjHaq6Or5R08+fjB9zeKv0gka
 sbkE5/G+Fod/rxuf4WJCxeRPC7ePMEIzHQm0plsXs88qyMJx1CwjiOelXtSd8Mrj
 wYqjSSanThgHZ3NzsK5JWGQrVJHMHR1Xq9DyU39z16Dqhph5QUeYybzmV4z8Qly4
 Xp/EhzfhkMmM0w3USAE4yDqGVd21lFYXCOYt0auXk6wRKmmWh0Zv0e1kujvW/tI2
 ikt2opTfSPjZzAcD+5XafNP3z+cZd69n45bkqVaJ7arg+akIZ1lIJG2Up4DQM0Kr
 Rm2Hag==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ukrbpw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:36:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-386b8624cf7so4085337eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795523762; x=1796128562;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D+M9rlByaDbbaT9zq7kzAImNLpeGnWkyEswhM9oCd88=;
 b=MEICeAs3L0pQo0yhY5hVTf6JN+3d/i/4DGLjlbaAZYghno+cBOVqqDWFgst6xb0Zuj
 PRxfsEGjsV6zf/k3o2SmN/c+J5vnRUN8E9fRLAj3qSHDetfKYKZIWeNDqAF5y98Jhom9
 PcC2zZzGUPulljgvSD3Jzd1wV+NJuAgKgoYTn/5DFfX6GyehQR2CLYqcUNvN6qtGw/5c
 /ENx8zvqpZ0M3tDU4sznZ3urWX2CLYFsbQEO8sMPHin6LJ2yWNjqosQNdfsCXVX4iMwK
 zkN833jk5KwQMBw2FDLiLGUtaEuAbl7I+ngFbCoRLl8NZBEesL4nycvsH4ekZv8Ov6RZ
 1pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795523762; x=1796128562;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D+M9rlByaDbbaT9zq7kzAImNLpeGnWkyEswhM9oCd88=;
 b=Nk6O408st7GGOuh0Wl13/pagEGtsIZwpz5DicQGVJ+0zBa797SS6Q3bdRgMMc5NKTB
 Y05xrVF187bqRZSsGsUfurypxmk6uZRQN/zNl499E67ppNoDSnyfuE6vc6dQu1vWfQD5
 I7hED84KEatyVKDKAdwtmis9+f2RqcT163ZI17umYbFmkiFUkRAwfuttkXviAYarrmxS
 9TCjwkjAgjBcELo96HoMqx+DFSQkOJONvvaExIKM0LmKwhMfFNtwA98Us0nXMYS7ogFe
 1uOEV1En3dHlmw48WDLKzg5WqyJ75tKaMYiwDcs1t1DcgRjzFkgc1tlfTPWEZrIGFMEm
 5KEA==
X-Gm-Message-State: APuU4Z8PtbpXZ25pigFwvOpiwWuhwTdC2sag1jzdc4+/HAYwzti0+rPH
 CJogE8pwB38/xD8CxGPaDIr4I49mhzo8GMeJsokUTnhj5JylxQ8W1gHKRoMTt3Y5JLMvI/lRo1j
 wicfviiI+NuBZwTFerPijwQUCjAbuHcSzKw3oZasjXQ7PovGN7RQ9ViPJZ1Y0IRZvoWdPBlA=
X-Gm-Gg: AZFdTZenZuRcn+DYWiyEnC0NQeRGM1lDkJ02n17Ad4UDC7MqGXRfLipNC0/5WIBcF6W
 rrXueNJ/vlD9+UhEIARWjY7X+A57pN57Z6AkP+IAO4rlH6rDosFVw+dFWf9pfX1Wppm3lGJWr53
 n6Mf4Eke3Y3Dh/ue5yzzyi5SLFb660cGoojxYhOUwXuuu0C57rruoDwEk52aMqSkdNpJQoteUfd
 wWqAvELIw3hd7JwuApatdklnLAqZF+8w1iWv9Vo5/CyP5xU15nQo4B7Z3l6PrOj6ojd9i/LA2CO
 uQFWoVH97WnYDIkXgsP+yhkAbdEscMT4vBum7rm9SvkAU3+sQWwpSuqBqn3hlHcPfB8InxlVgyE
 EPcTvkxFHEEhJ0KyTxDmrsTeHmjuSU0bI9qen+ywgL9YFt4VkSd6Jg8LAQMzifNi+fXIu8cs+RR
 fw
X-Received: by 2002:a05:7300:f498:b0:386:a716:916b with SMTP id
 5a478bee46e88-386a7169544mr8892948eec.31.1795523762226; 
 Tue, 24 Nov 2026 04:36:02 -0800 (PST)
X-Received: by 2002:a05:7300:f498:b0:386:a716:916b with SMTP id
 5a478bee46e88-386a7169544mr8892918eec.31.1795523761411; 
 Tue, 24 Nov 2026 04:36:01 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm56005126eec.4.2026.11.24.04.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:36:00 -0800 (PST)
Date: Tue, 24 Nov 2026 18:05:56 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
Subject: Re: [PATCH v3 3/9] drm/msm/adreno: migrate zap shader loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261124123556.ymiwo3sygd6pqu2a@hu-mojha-hyd.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-4-mukesh.ojha@oss.qualcomm.com>
 <sashiko-outbox-219162@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-219162@kernel.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0OSBTYWx0ZWRfX3Dn53QFuPIlA
 3PZP3bLEr/hX+RlJqNaa21mh/8zPr3P8+SkYI3MHa8tsM7cQ9LzbdR6IYvcgQy8+R3i4I449LgG
 +/pUZRVgWr2cynQ6dGRQsHSZSIPwtoQ=
X-Proofpoint-ORIG-GUID: AJf0l8pSYzz3g4LxxR4EpWeFfcmDdFoz
X-Authority-Analysis: v=2.4 cv=M+rYuCws c=1 sm=1 tr=0 ts=6b0584b3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=550VJpOQ4KLBjvVCYQEA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0OSBTYWx0ZWRfX8FHr97/be+s4
 DoNEGksK3llWR7qMlLOu9M5Sscd6hHLaWga97+TkyzBwQBePAZSPT16oy9mhq8BO5n4TmZ+2gFa
 suonErmpN4DUMmuf6L09iTKmuBfQFHjqaOz9hgYYK6jK+wLCVMeM6kz3+ckvlOe+Mfm6f0eJdbA
 V6pXtLVgR91uH1gyoMHLnJUs0SQfVNgJ/g3H7BQY1gYauWZZixpLOu1PH8T+G8Ki36ON1CXEB+j
 pkzrlQJdF2RujThztLTtvNe8N75OAFMj5zcumu1Auxt6mIpz7PAdId7Sa+Zk0Qei1sZjMEcFY5Y
 ZV5mnzWj43q4fE9RS7O+dlSZpDJdNwm7VsyzDKviSvN5gbK0ElmITT5LfHanpgrBe5Ius26RkqR
 lSBdNps/W+/RwnkR8Q4UuAv1s20nkEK1XcPx6wo9scjVinbGm5XA10jjTXfCPksEO1cC1nhxKoe
 WpNJtJ3+TWvj3K7FbQg==
X-Proofpoint-GUID: AJf0l8pSYzz3g4LxxR4EpWeFfcmDdFoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240049
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

On Tue, Nov 17, 2026 at 04:24:10PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] drm/msm/adreno: missing qcom_pas_metadata_release() in
>   zap_shader_load_mdt()
> --
> 
> commit d13b2477d9bf69676164fdb8068bcf949f328d1e
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> drm/msm/adreno: migrate zap shader loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit replaces qcom_mdt_load() and qcom_pas_auth_and_reset() in
> zap_shader_load_mdt() with qcom_mdt_pas_load() and
> qcom_pas_prepare_and_auth_reset() using a stack-allocated
> struct qcom_pas_context.
> 
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > index dadfe4c694384..12e35841763d8 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > @@ -34,11 +34,11 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
> >  	struct device *dev = &gpu->pdev->dev;
> >  	const struct firmware *fw;
> >  	const char *signed_fwname = NULL;
> > +	struct qcom_pas_context ctx;
> >  	struct device_node *np;
> >  	struct resource r;
> >  	phys_addr_t mem_phys;
> >  	ssize_t mem_size;
> > -	void *mem_region = NULL;
> >  	int ret;
> >  
> >  	if (!IS_ENABLED(CONFIG_ARCH_QCOM)) {
> > @@ -121,39 +121,32 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
> >  		goto out;
> >  	}
> >  
> > -	/* Allocate memory for the firmware image */
> > -	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
> > -	if (!mem_region) {
> > -		ret = -ENOMEM;
> > -		goto out;
> > -	}
> > +	qcom_pas_context_init(&ctx, dev, pasid, mem_phys, mem_size);
> >  
> >  	/*
> >  	 * Load the rest of the MDT
> >  	 *
> >  	 * Note that we could be dealing with two different paths, since
> >  	 * with upstream linux-firmware it would be in a qcom/ subdir..
> > -	 * adreno_request_fw() handles this, but qcom_mdt_load() does
> > +	 * adreno_request_fw() handles this, but qcom_mdt_pas_load() does
> >  	 * not.  But since we've already gotten through adreno_request_fw()
> >  	 * we know which of the two cases it is:
> >  	 */
> >  	if (signed_fwname || (to_adreno_gpu(gpu)->fwloc == FW_LOCATION_LEGACY)) {
> > -		ret = qcom_mdt_load(dev, fw, fwname, pasid,
> > -				mem_region, mem_phys, mem_size, NULL);
> > +		ret = qcom_mdt_pas_load(&ctx, fw, fwname, NULL);
> >  	} else {
> >  		char *newname;
> >  
> >  		newname = kasprintf(GFP_KERNEL, "qcom/%s", fwname);
> >  
> > -		ret = qcom_mdt_load(dev, fw, newname, pasid,
> > -				mem_region, mem_phys, mem_size, NULL);
> > +		ret = qcom_mdt_pas_load(&ctx, fw, newname, NULL);
> >  		kfree(newname);
> >  	}
> >  	if (ret)
> >  		goto out;
> >  
> >  	/* Send the image to the secure world */
> > -	ret = qcom_pas_auth_and_reset(pasid);
> > +	ret = qcom_pas_prepare_and_auth_reset(&ctx);
> >  
> >  	/*
> >  	 * If the pas call returns -EOPNOTSUPP we assume that this target
> > @@ -165,9 +158,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
> >  		DRM_DEV_ERROR(dev, "Unable to authorize the image\n");
> >  
> >  out:
> > -	if (mem_region)
> > -		memunmap(mem_region);
> > -
> >  	release_firmware(fw);
> >  
> >  	return ret;
> 
> [Severity: High]
> Does zap_shader_load_mdt() leak the PAS metadata buffer stored in ctx.ptr?
> 
> Previously, qcom_mdt_load() passed a NULL struct qcom_pas_context to
> __qcom_mdt_pas_init(), which caused qcom_scm_pas_init_image() and
> qcom_pas_tee_init_image() to free the metadata buffer immediately.
> Passing non-NULL &ctx via qcom_mdt_pas_load() retains the metadata
> allocation in ctx.ptr, which is leaked when ctx goes out of scope unless
> qcom_pas_metadata_release(&ctx) is called before returning.  Note that
> 2aa8fafc08e7 ("firmware: qcom: pas: Make MDT buffer retention explicit")
> changes qcom_pas_init_image() to release metadata unless keep_mdt_buf is
> set, but that commit is not present in this tree.


Yes, that  commit is present in the next; so no issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com?part=3

-- 
-Mukesh Ojha
