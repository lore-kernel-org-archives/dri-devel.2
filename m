Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C86606A331
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXQw/dZe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XwKKSraC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1845810E22E;
	Sat,  7 Nov 2026 04:43:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97D4D10E045
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 04:43:22 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A74dtJD221361
 for <dri-devel@lists.freedesktop.org>; Sat, 7 Nov 2026 04:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=b+VmH62ABNPAXkSzeLXOUWJyAUNp6hJ01xdXPzH/7e4=; b=VX
 Qw/dZeFsTGMBxP819rfn+TGMbCQaHroanEkDnJrtwq6CfkiV6FjfWeLmsKrmHcLi
 9EQ4FcXRhDxyVl/L7KhCzef1tFwtsGuHP/4M9et8BTkVbnC7MhKAMlepDWxRgmUh
 rWHj3Z+y9KXVgrg3vTF3Wf0XJUCmZy/wp9Rj5tPiOCiLhXHlJ/NhuKD43zmDZmrh
 ++0I83DmOqDTUV1VKTNosuDfsZEffxp1aI3B9JfHZ5VqXxPpSqa3uTAp6pOVt7rY
 PMJ760gZQ08Mkz1GJaTpjY4Mopq3WNTWROdjxanR8u6hr4K3lPuY7piVrayeWLrl
 zq4Qt6g5oYRV7hmyB9EA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k007f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 04:43:21 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6f4d828b9eeso1059146eaf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 20:43:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794026601; cv=none;
 d=google.com; s=arc-20260327;
 b=OAQUr8+DmWEfAA4PbDeeFM8FuELMymLV3mqy6LBRZZIGwGXZdYX+WtSLmgl4f64B2a
 3Qis54FMboMA77/Nx6+avBFLM1MzAlqkiA5ANRkCTwvQkh/x33xq7+B05vDw40RkYaCo
 1Gv2GroQY1L/OOauXUKr62o6sASwRN+WkWQUVTTinZHqPDrg30ZhxQynXCNhSEFsir6f
 nJetuc+HY9dp6N6MYrEtAYzgQ7M8f1GIAEglqodsZKQBXOxV7uB8JXv0QMI5Rva0aF9w
 ifduprQRejHwhapcA5+DyOQn+rWJ7K9Mg9uFnj4xrWPdi77qqfatwwZlCMKYhy3ncDi5
 1DHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=b+VmH62ABNPAXkSzeLXOUWJyAUNp6hJ01xdXPzH/7e4=;
 fh=9FuQe4TuuueTtpr9/+yljRcibCuX8LKBuTEqEPf0dDw=;
 b=bXa6+1h2tQ/nrIHiZ26nZmAYApwMS89I5cq0c5JMolAqqa0QNtmg+RtGHcZGGoD3Oy
 rQIdu4FozYSfNkpyDIGGtubPf1FpxSj806WFLxB5oeg7zr3vj+rVFWPgwR50Qp4Ccl5S
 BBMlIR/IDhng13sXpPSF/bCElor24SFlwV55SqM375b6lbQiC9rzLnfnc8GreCGZPl/O
 iWfzv7YmuOWfyYlxc3MlfzZWfylYvy4zvBjtS2GgesjRRLJaFbTlNjWeKF63tdiLSr03
 BtcC9Y6ZOnStDt/PTyKYgZ+ajDK4pL8Lu4pn0UgO4BHfVSS3PsClp3pnWf9CpONomViO
 b4nA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794026601; x=1794631401;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b+VmH62ABNPAXkSzeLXOUWJyAUNp6hJ01xdXPzH/7e4=;
 b=XwKKSraCASdaxDLvok1n5H/QmPW47/UVz/siQCO9A+ERmOazmamfvOWOVjjdb6vQp5
 GA4pEXbem2P8J2lu4tK61EULInJT5wnvDucRu22UF07WrO2DF3p9tHMoEmn0DBOfjWfr
 UIvQqqycpZp6OGivtOkZYdGsd4WSAx6yZYuUX/ygPRhGHRYh/IVlpUv1rJP/iT0HAiaG
 wSpoOsPeTQCwqDa/2ELwtIb9unmvUpOTxfh8zPyk7Sg5wXsE26bf75O1m+/3eV7G2pnG
 cDzYRuFwx02Rvoc93h25sugdIz67XOzn9y95Hg2BGCDj2Y1T1U8EI8iN289dY/5PHiZd
 +Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794026601; x=1794631401;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b+VmH62ABNPAXkSzeLXOUWJyAUNp6hJ01xdXPzH/7e4=;
 b=bCoWWDtyjilv0nceNWNqXiTFBDxCG5KyNAU6fHvkOiEGU41AFywRB9P9P915j8bpmp
 5JJSd7oUugAxj1leT/su7vWRBwezt1EjJJMr723wQns2bMj18pKIDtOhkua7BisEizCV
 VhPgBeKI58JLOr3S8bDID4z/pPIvx6PHFJAy/zN9orFiq1XJcdHPEhpJBRqZdJnsIeps
 YWG4wn1Fvp5ktFKWJkHzvmTM+waKBE+TpWPFcx/67G2RYdRSvGqXKog5UoxLMSyswX/J
 ++HX3Y1hgs0XVeB6QLF17SrcagIKOfbO9TOXnAILzx2ubjOYtHlwaYQf9U3nPigU1v4k
 Q8Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPSm48QvjMA3SEFLnBGY7KZYigN1BaoPYg2KDNFso8F+E8BLaf1MmNnPKxgmumFmw8UsIIf3HgjBg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Pdtw2ivVVt/gLPyXRS7RRoBrhjjziRxSZ2VbyarFwRk1kAJgY
 at1N4IeB4gYB3wYUhC3G1YgQfDULocYzV/w04c36vatXJ/ArcubQcAin6AXVu4BGSunTZyiWceQ
 8h8SSNdktSY1M/MYp+qi024XzloykupOG4ZvXEMW8nyVpzMYrhsATpveEOVixm6kK+jdfejeNCB
 KsNZ8KsWgDrPSv+PN6v3J4J4Z28pX6fFAMfdVZl+H9upsAuQ==
X-Gm-Gg: AYBFou3cjWZng/3fxqMD48x9hzITSwULmKKvSQvZ5bbnwOj6VLErafaLytuOz3N5zen
 /yRiaymzKA9sGbAf90MDqIrtgnhg0veAyNOOngf6I9USwDQ02VZFFKF50tKDgVIUqfsf5sBGNlZ
 w+2km76xsNP+PwlUo3mkGTh5HvLpTos0jVuBN3VrbKznfjcan65h7jMps+bKNOOYkOgMxIJnPvR
 jjlI4rE75XfBoVBwu9dLw==
X-Received: by 2002:a05:6820:340b:20b0:6fa:f881:7bef with SMTP id
 006d021491bc7-716e7938ab7mr1898638eaf.46.1794026600911; 
 Fri, 06 Nov 2026 20:43:20 -0800 (PST)
X-Received: by 2002:a05:6820:340b:20b0:6fa:f881:7bef with SMTP id
 006d021491bc7-716e7938ab7mr1898634eaf.46.1794026600505; Fri, 06 Nov 2026
 20:43:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103011358.65398-1-val@packett.cool>
 <20261103011358.65398-5-val@packett.cool>
 <07d29a8c-1caf-4041-8c01-845a51d11a68@packett.cool>
In-Reply-To: <07d29a8c-1caf-4041-8c01-845a51d11a68@packett.cool>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 20:43:09 -0800
X-Gm-Features: AclHuK8ZvCB0v91X3y3MGuHIzYr_FPdHK9w1jmFQ7gzccPmsaAhQMvCJpL68CKA
Message-ID: <CACSVV01eJ4sxzZWC-RxKW4OLvXPmC-auru9-wTFSY-CPQpRVnw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/msm/a6xx: Import a680 hwcg sequence from kgsl
To: Val Packett <val@packett.cool>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAxOCBTYWx0ZWRfX7lps2XUhAkH3
 /s/agqus8FC1UDTbUmtkIlMbmqFhzeRm4ChVCWP6JDa9a3nyzIEtamGDa4MIyBuz8WzujCZbF4G
 uLt+Bbqs9Zg8q570K9gw7BroqWi6teqpdrUTB3hVAyIiSAl9nl4Y6sSEHkJuD3RhuWLOuLVzQZy
 8ke07dsa9PBW5tNrUVJ4XPjoq33t4LtaShaWGNqBsljILdJW+LjjLUY4teFI6B+swXg/P30UJfX
 caIPbBpWTrulNoNYXVC5TV05G75VCh+/e0qp8bgry2zd4q13iuja/YvURkHkAU6vOfiXbcvtJYE
 Age50Uu+ead/X+/ZOre5cKJtgzkkbEBwkjmK0GjcRS1j9p5grs4UKMG540cLLog2xQe4R6K0d0C
 iPHL4G1+tFB8q1OFjh4jRZsppfTX0qRy5oyG2BIq17XWwcV+8IzAsZBQX//x/9gePWQU+O4HbNl
 d9VMUbtrI2WywI3xysg==
X-Proofpoint-ORIG-GUID: Y36dpTlZ46UfDISu33pJQRUE8VXSaBbw
X-Proofpoint-GUID: Y36dpTlZ46UfDISu33pJQRUE8VXSaBbw
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6aeeac69 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8 a=17JunTclo9ORA5DUsrgA:9
 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAxOCBTYWx0ZWRfX9K1vpkcWQ2OK
 Z0QH7dr8AzmYOCI0AC/UD2HLN1mUZsb+FrAFZycvkvqUG1A26QBwkIgpJ9YYuPbv07BUzmALVoK
 0pWEckCl1P3v8cPe9DVXeQkb+1cBLI8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070018
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 5:39=E2=80=AFPM Val Packett <val@packett.cool> wrote=
:
>
> On 11/2/26 10:13 PM, Val Packett wrote:
>
> > The initialization sequence for a680 differs from a640 in a few places.
> > Match downstream by using this a680 specific one.
> >
> > Signed-off-by: Val Packett <val@packett.cool>
> > ---
> >   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 56 ++++++++++++++++++++++=
-
> >   1 file changed, 55 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/dr=
m/msm/adreno/a6xx_catalog.c
> > index 6c154792cb07..48197a54984c 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> > @@ -9,6 +9,7 @@
> >   #include "adreno_gpu.h"
> >   #include "a6xx_gpu.h"
> >   #include "a6xx.xml.h"
> > +#include "a6xx_gmu.xml.h"
> >   [..]
>
> (As sashiko confirms it's not a good idea to try to write the gmu regs
> from here, shouldn't've gotten lazy and assumed it would work anyway..)
>
> I can make the gmu driver write these on init, but would like to know if
> they even do anything interesting, and whether the entire hwcg sequence
> is worth it=E2=80=A6

vaguely related to [1].. I guess I'd suggest to do something like that
for now.  Longer term still tbd but dt gmu vs gpu split makes tables
generated from hw view of the world run into these quirks.  Longer
term we'll do something to clean this up, but not sure which route yet

BR,
-R

[1] https://patchwork.freedesktop.org/patch/767327/?series=3D176505&rev=3D7
