Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T8s0O8oa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DrBa1tda
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3203E10F56E;
	Tue, 24 Nov 2026 12:51:42 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8AA10F56E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:51:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuVpD1736762
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ibJhgbs8/LooGaGNxFqStf7aw570tanCnoATpq0oEzg=; b=T8s0O8oai12DBKf/
 c6wBIfydU0YYgm5yfki3odjZT5fr1w+ee4GFuopg2XEDBarVa7ow3vdvkswIRkf0
 77GkTq7/82eruwfufnVMiXvuyA2bkdsy2jZ2ZPMd9czm0qjo6M9y2pJjSDBnF4XZ
 aJXLuHntIlrJouKU7EOQ9fbyftrWWYM99Ab3LGQzLeCkKPPptnrdnzVl++fJ9Gnm
 o0bFNBsRz0xlzIsMIvIthD2LKQ7qD8X6Sg4wVcKwIxiv1ykLhxXzG9i5Ca9tFf2d
 i1nD7QOSPHgFIxjxZcEoNi+i0UvlqHrcoNdbfMk3Zz3lI5IUMsczB/1/v8MtrKdh
 TFXudw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd2s20-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:51:30 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-154e9d2d94fso5711908c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795524689; x=1796129489;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibJhgbs8/LooGaGNxFqStf7aw570tanCnoATpq0oEzg=;
 b=DrBa1tdakeKmas9064w//UrdD0QQ7FuvAcsST7AqYY4f/UfXkFLgQEUKVNWdxQJCgO
 C+S67VKWg6onaGAW6wjvP5MjguVEA+BDVpxqM9KZjC0M3T02CA96miJBYMIdCQ5Qs8yA
 /fUDOIv5fjZFmoT+fZ6nKhonna2ZXE055YbyUmaT8TgdUY7+FOTy5KjVb+DN8geIDvf1
 f62R82izt6D90HIPWE0EtfbnGDdIgdPPDIRzwAkzUZfCO4CJHscRHXSNZYLfIMDKtS1p
 qsyo3UNikR9SwgLCoAO0v1eHOGIWCi7CBuED4EjbA4oJcEU/K9H+M0ONi548I+TQ2R0J
 vjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795524689; x=1796129489;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ibJhgbs8/LooGaGNxFqStf7aw570tanCnoATpq0oEzg=;
 b=XvZzvWmWTDHP9qBMkJprQQ62oIPne7okKdqQ05ByBMthy+bj0ZLYKq/cFC//OI2C5c
 vy5hKD9bKm44jGhJu72+j5gZZfeOHIbrI0Nr+bIfnZBm03h2L8ul8VPxFpXnnrjF9zL0
 of+SF7v4V2NPfKRxLGyJljccFyOoHASOENz+WsiTw/AFYQVbq/K3iOEeKAP1jv+z1+X9
 +RSRhCRV7oSWK1dygxtbBTChAqB5gD0ouuT4yidNusSC8XtV+1Mf/QCmbyGohfR/5vLb
 yJt2N1Lviz0Glu0H3+ZAys+++M/C4y9MIMCVwGYuAeMed3DSw6dY9vEVNx3gC++8eDXr
 0+ag==
X-Gm-Message-State: APuU4Z/Iqhk+uP1EkS8ZY0YUltcfaDe0S/KpnDBnok5QGu8Rgfu0+Gde
 VfmpNDdB2uUuCqw2gohJZi4+pNNRa6cMUGU2fuDR715muuyV9VGy5bZODcYtR4nWUxl0QcQ/Tbs
 6m05Nv/HE5S2N/w8v3h9OxX5pR+4AuQAAyPEHLX4O4WbkNuB+x2e7ahdUyxKdOMW0jAwvl2nGb6
 Ww3ec=
X-Gm-Gg: AZFdTZc/mJkt59llVQjDmVPPnvkRFeRKIReCP8umluiWa01uGqheJuX/Adh+T6jDltR
 rVbzuZpIt1kojNiP6suhmcxaPl1cO2gUbnZAe+brgnOcZUPY59s8GHK4DZvkJk6nw2/ltBwpWq+
 1Rs8wbqAoUBw5jPw31Toek+pTWuptdRmBR+u/7bjKqztch4+FzrHqNnDQoMabzqM6MbUKuucPfg
 Dy2cR3XYJx9oZ8/Davwo6sOkZDUI33Jw/abqIp0wH1lmZ763gnmSB23nPY7+ypZtgbxGwFiHiew
 lt/155gTKlF6HORriJN+aFkoY2cXmzUj75bhYIlWf16vPqHG+1o7KG+QI1cbeaklJpV88IATO4C
 bR4UXCnk06vDeFP5ctpaZfTd59GPyslHcq/okOkIhj3L5AY7/2LEOpBrL0k36GuX7Nlk8wNwVl0
 Bs
X-Received: by 2002:a05:7022:b051:20b0:1b4:e533:ff50 with SMTP id
 a92af1059eb24-1b556912ca9mr16371244c88.40.1795524688647; 
 Tue, 24 Nov 2026 04:51:28 -0800 (PST)
X-Received: by 2002:a05:7022:b051:20b0:1b4:e533:ff50 with SMTP id
 a92af1059eb24-1b556912ca9mr16371218c88.40.1795524687943; 
 Tue, 24 Nov 2026 04:51:27 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5568592adsm34495458c88.15.2026.11.24.04.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:51:27 -0800 (PST)
Date: Tue, 24 Nov 2026 18:21:22 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
Subject: Re: [PATCH v3 6/9] net: ipa: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261124125122.dvdl5y4lky7zffql@hu-mojha-hyd.qualcomm.com>
References: <20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com>
 <20261116162148.2864501-7-mukesh.ojha@oss.qualcomm.com>
 <sashiko-outbox-219165@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-219165@kernel.org>
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b058852 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=SDal4quw-ZMABC504UwA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MCBTYWx0ZWRfX2k+G48d4QZPb
 f69EZiG3sOSMoNGTneZgaMZQFDfOiwCsn+P9nPfe1qJ3HPmwhR21pXohma/X0sR01l4gRJFxyJl
 x6fiU3e3tdlMormF643lcl/zS8tS9+oBuYi39naRSU+y29GsHw8l+9KQYAp32IdvdSXDpk+eWR9
 rcUcCJ6Lgkxl+tNA47H0gBxPcGSjbpLPsMsdptTxKKiWUw1KO6wpnisApzWftLK83lq27ZRuP+/
 3vK/9gQOhpkkczJBM4toM5XKulXbArYjFKi8Hc7wa5Da1G5knSIfSslSVBRxdUgPMAZ6ChlhVN/
 JyKgRBWhKBjrVWjMjWjhCokc4cLgsA4V5E/fU2GmdFN8wgoyOc49+eacjnzdu350zjEBn4Zvkg1
 gSRiFso4fgjDOGhso25DDEXUKMAG7VLdduXhQHGWveRYRZ/FKaYgbNALoLiwHSRxtyehc2qGgj5
 b/REFaRBQ/W54sVVubQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MCBTYWx0ZWRfX8FY4/fty36FI
 v5rFMI6S204accEJ0CmBDh5+rjHuDkAAQWGA1VZRtwGNjkA0IJzkmHKsPZ7bSs3Li172rmqdafk
 Ozo3oTnPkM3JlSEYIqOR5Nd1JVi46PQ=
X-Proofpoint-ORIG-GUID: z87zm4ZeCmsDTSKBelxJRG9qtfi0lVVc
X-Proofpoint-GUID: z87zm4ZeCmsDTSKBelxJRG9qtfi0lVVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
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
> - [Medium] net: ipa: leak of PAS metadata buffer in ipa_firmware_load()
> --
> 
> commit e29d8ec88fcd553654746e0eff27a3767cbabafc
> Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> net: ipa: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
> 
> This commit replaces the open-coded memremap(), qcom_mdt_load(), and
> qcom_pas_auth_and_reset() sequence in ipa_firmware_load() with
> qcom_pas_context_init(), qcom_mdt_pas_load(), and
> qcom_pas_prepare_and_auth_reset().
> 
> > diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> > index 14ac2d2faf7c2..0a37741c22858 100644
> > --- a/drivers/net/ipa/ipa_main.c
> > +++ b/drivers/net/ipa/ipa_main.c
> > @@ -585,12 +585,11 @@ static void ipa_deconfig(struct ipa *ipa)
> >  
> >  static int ipa_firmware_load(struct device *dev)
> >  {
> > +	struct qcom_pas_context ctx;
> >  	const struct firmware *fw;
> >  	struct resource res;
> >  	phys_addr_t phys;
> >  	const char *path;
> > -	ssize_t size;
> > -	void *virt;
> >  	int ret;
> >  
> >  	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> > @@ -615,24 +614,18 @@ static int ipa_firmware_load(struct device *dev)
> >  	}
> >  
> >  	phys = res.start;
> > -	size = (size_t)resource_size(&res);
> > -	virt = memremap(phys, size, MEMREMAP_WC);
> > -	if (!virt) {
> > -		dev_err(dev, "unable to remap firmware memory\n");
> > -		ret = -ENOMEM;
> > -		goto out_release_firmware;
> > -	}
> > +	qcom_pas_context_init(&ctx, dev, IPA_PAS_ID, phys, resource_size(&res));
> >  
> > -	ret = qcom_mdt_load(dev, fw, path, IPA_PAS_ID, virt, phys, size, NULL);
> > +	ret = qcom_mdt_pas_load(&ctx, fw, path, NULL);
> >  	if (ret) {
> >  		dev_err(dev, "error %d loading \"%s\"\n", ret, path);
> > -	} else {
> > -		ret = qcom_pas_auth_and_reset(IPA_PAS_ID);
> > -		if (ret)
> > -			dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> > +		goto out_release_firmware;
> >  	}
> >  
> > -	memunmap(virt);
> > +	ret = qcom_pas_prepare_and_auth_reset(&ctx);
> > +	if (ret)
> > +		dev_err(dev, "error %d authenticating \"%s\"\n", ret, path);
> > +
> >  out_release_firmware:
> >  	release_firmware(fw);
> 
> [Severity: Medium]
> Does this leak the metadata buffer stored in ctx.ptr when
> ipa_firmware_load() returns?
> 
> Previously, qcom_mdt_load() passed a NULL context to
> __qcom_mdt_pas_init(), so qcom_pas_init_image() freed the metadata buffer
> immediately.  qcom_mdt_pas_load() instead passes &ctx to
> __qcom_mdt_pas_init() -> qcom_pas_init_image(), which retains the coherent
> DMA or TEE shared-memory allocation in ctx.ptr until
> qcom_pas_metadata_release(&ctx) is called.  Because ipa_firmware_load()
> never calls qcom_pas_metadata_release(&ctx), the metadata buffer is leaked
> on both the normal path and if qcom_mdt_pas_load() fails after
> qcom_pas_init_image() succeeds.

Change https://lore.kernel.org/all/20260925165231.10722-1-mukesh.ojha@oss.qualcomm.com/
is present in linux-next which takes care of this.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261116162148.2864501-1-mukesh.ojha@oss.qualcomm.com?part=6

-- 
-Mukesh Ojha
