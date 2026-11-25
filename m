Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6531606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1iGMU5+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EPsRHiuE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86C710E92A;
	Wed, 25 Nov 2026 15:07:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87BB10E8F6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:07:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APEMJDl175501
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=; b=g1iGMU5+iI+taWPx
 yLKnXluxP0uaMQZ6O5vPH2iEJkzvOVHnbjFOxlUKSgN9I0PnTwKk9RPx0tz5phAE
 cWXakaxrTlDBuo7Ig0ayxg17cVaHRUvakyzifrARLhcIgTZpCsEH6XS8Zm9/J4wZ
 RXv0fAKx89tE2ZoK/4K+jz6tuSEyQjzpKoEat/afA6amSKDrjYvpqTeB9cRZsJbX
 pRXFEREHLj3Q0aKAwidv2GoSEMoP/vmxEhm0axosUN/os6TTs9KZmu04624uM7Nr
 ASb1nzQhhyAYBm/r0M49GHRkHxqW+wg42e+m20IdMGvKqw2YgnMNycX1SM6phLCC
 sLz5Lg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2sda0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:07:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ae7faf4ff7so7093475a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:07:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795619252; cv=none;
 d=google.com; s=arc-20260327;
 b=ay1ibyHRZdb/GD3s0ORVrCb5Qc8/ZDNlki8R1s0yblOPYh45z6bz1S6hqv8qiOX3Yn
 kXFhJJRkhLMOxK+ND+gPCQY/tudYLLbMmuTgUYyjqLITKO2JpVea1xW9I8MzGNJ4eiSL
 FDGL4B/10ooBaZ9PqGcn2MNy1IiEXOJyBP7gfAKr3EeYgLlAZx2bCsS0ryaZjCUkcEim
 uagy7xweOqsJr749AbGHF0XanSK+/XohHnjDz0dzNSD++HZRIuwUPz8bKYOxwi8jZKsc
 JNp03YjdQ4kWzxyanFEsS+MRXbggTdd8p/jIifTks7AtO1e76/bim4kR3Mn1l+6/UCUI
 tE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=;
 fh=299Vw0PAyS146zPtaLBCaAI0DoIqIPyipyL5vb84nHM=;
 b=NLyvr19ijnYDvhSO7wWaUqJF+B2njnSUMv1ZOvJyRktUFTqcQSuUeWnGW7UxVSWuLH
 FXi3PLQ86Q3GVp2YZRYZ3S2mZSVM0f6WCKZ1fM1Rqi3k5X2gSBr5/w6wMmqvN3OFsIWZ
 sxjvJkypxcu1XZ0dMVEPNNn25SJamQjp5Hyf4ymIL7Ir9eHyf5uO6EU3YhLwUWwAZTY7
 rtJ16HNzhwGVSgogDhkUGFYOsMUnIClnIetthrUKOmegjKBz1U5Wie5bkMf2oAw48TFo
 swYT7fI0uY80ts7j23BE81wwJb67W+Em6l9Gc51MIppuexDS0ncRspwfUz71nnQ+e4bo
 UjTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795619252; x=1796224052;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=;
 b=EPsRHiuEmcDeSMRz5zP0OSascypSOX53tKuaKhEldfsbrS9iFQTo4GbzAJtkr6VsGD
 7DxzkwcEixacmZaW4rDS5sc7xE5l9UFpVf5z34ajzPR0DEV1wLKirKWg8Ojfl/+J0i7P
 EsTwnAy2CPUBrkTZC3bDpGe4wfjBHBMGBsHLc2/C5zZsvS6xrDLiAiqULUBF19fhpBSu
 fJx6HLYlwDaRpWP41LKA4f6hmQe2qy7CxcZNf5mOzyCuR77wqCwKQW7VLQdy0gz2BCGY
 Opkegm/A9X/cWzfZnMk9X22Ebav7E2rJjtILOP9oeF6qK4uRpISW8eYid/BjJe4IWQlc
 wTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795619252; x=1796224052;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=db+Ha9wyQwvqpCYlhHffmTpkau51LqeWzqMbVXiyKQ4=;
 b=d5aHKeCJGPYp1ZSVMg5/fTWU3J5memKDZMGMgVxOFJKsMDLDPNN2+lwUwIzIaqOHtE
 uzEBoPtRLOiJ7QtkVR6kLgmDEtnlwQKoZIQL8VaqPoQAIbtiuStLN1mD/OzjIFykmM4f
 UziAjUnp6WNsm/ax+XCLzadTiQYg/0NiwECEcndMat4zwxL//pvRxXUK01H1r/kde1Zq
 5G5/hPTYZFsOzLtZC9Eij1msP3WY4f+duUsRz/gcdRf2xZxZWQ9JNs5Xx6yWxT9K1S/G
 kPFlYr42GUxsQ1Q9p6yiwlanAJg27gvzVCiBkcBvS4kGXhp2Hrwqqvh9y/BdhGXie54U
 qAvg==
X-Forwarded-Encrypted: i=1;
 AL+hErHqghF2rjwb4tUKGVeLj3OGKSkqiioT0TkGGmwrkrcdEDqWiaVT2hvNv5fM8gRxsmAnv0rKMV0AwkQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ejRUgifMHUd4TxjJFRx5ZAZUV47ZQakLatuRSQMOLB6+EKB+f
 2m+kBuW5D/FzdPtRKMLyITr4RK93/RWh3uY5rv1BQsUMJN7RBbCeInA91d+y4OzYqvfz2LfBvNO
 7MkgMB/8iT0xH8S8R5q5oPSIYdV5tOkHinq8OXVJQFUdUErBBAwng/8Mi0siuypDHF8fUNcyCmv
 rl439VlnihTPlAkKOgOOhTuVkyokiKg1H9Jn3JhuJDXv+b9g==
X-Gm-Gg: AZFdTZfTRRp4uW+YhMIpV4xsMYzj6+gaofvF1JpsE8lA5w4/w9kNJ2pSvpIzsjdj51S
 LoIuy5XDCPEPvRxw582vm0uiQPMLLsuQI15lp/t1xtx/V2GFAGFhmkDtV7Mn0xuIo1/skBwKMSD
 GVhKJ0fvviBIUBoNtEetsyJYk57agNWSx4VPrGmp3F8sX2y/2Swj3eNZXFQg==
X-Received: by 2002:a17:90b:4983:b0:3b0:97b8:d6b7 with SMTP id
 98e67ed59e1d1-3b41c931d29mr17812795a91.42.1795619251705; 
 Wed, 25 Nov 2026 07:07:31 -0800 (PST)
X-Received: by 2002:a17:90b:4983:b0:3b0:97b8:d6b7 with SMTP id
 98e67ed59e1d1-3b41c931d29mr17812748a91.42.1795619251127; Wed, 25 Nov 2026
 07:07:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117173738.1073856-1-Frank.Li@oss.nxp.com>
 <20261117173738.1073856-2-Frank.Li@oss.nxp.com>
In-Reply-To: <20261117173738.1073856-2-Frank.Li@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 16:07:19 +0100
X-Gm-Features: Aa3M54qdNdgAc_JRldH76LdEJD_mei5kpsUzvFW9k6ee3hswc_FKGO5qrF_F3iw
Message-ID: <CAPx+jO9RwkpSKwq6vq00uoXK-mcovJ2LMH7b_ByRnxOUj8nH8w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulfh@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Hans de Goede <hansg@kernel.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
 Tomasz Figa <tfiga@chromium.org>, Marek Vasut <marex@denx.de>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@kernel.org>,
 "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-arm-kernel@lists.infradead.org>, 
 "moderated list:ARM/Mediatek SoC support:Keyword:mediatek"
 <linux-mediatek@lists.infradead.org>, 
 "open list:ARM/Rockchip SoC support:Keyword:b[Rr]ock[Cc]hipb"
 <linux-rockchip@lists.infradead.org>, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dafna Hirschfeld <dafna@fastmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 dri-devel@lists.freedesktop.org, imagination@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX6P/VB1KyUcKS
 a14CHM911iBF2c/lur2N5LtSridbCDPyAlpim1PKh+vp6j5AevoWwC4nWISlcqht5q5ql22kYLA
 xaOvZPFy+IYwXwYTvb0ST1y87v3fSLQ=
X-Proofpoint-GUID: uhMbqcf2harFwqWdUvQFc9ziVrrxmjDU
X-Proofpoint-ORIG-GUID: uhMbqcf2harFwqWdUvQFc9ziVrrxmjDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX+I8q4kXVvb73
 IyF7WW0qMrSPfZimxaH1VrI1hJ/CixxhQE94ySi78M6SzYR5/GIJ3AFti/aBNSYe9ZQXaq9edbX
 k3puxLF908c9zkXI8Ug4kmD81WCDVH2Z8opUO4gIEwOO7cCAN31PWb1DBPAj/Sl3yEXhyZLGvB/
 ZbOTLuaAvWW+eRsAIVhbdIrvrVz6HkvdTene9fml6nEX2HvRv8J977yjUPJ2zuGzf8VBmUInO5G
 WBhRlytaiKLVj/fOus9F9OQV82MB5f2QfMz8eyGcR83NXYjG3nbixhmQOehnFumA957h74pRsMg
 E8AIBsjHO0jZJVbfXXYqbg87nNWGxlBDMfcCIAEa+olrS9HC4bRHQZxdrq4l+qYNcaMgjCIo/c6
 z/IUFZc5orreUFO4QYio3jwdNDHh98+fHRt030XtyhoAdDzf+pLBUwi5vG4PLMYqqpdC7D4EXJE
 sgUXOq3MN2J7ox+WSuQ==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b06f9b4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=GFqr32JmAAAA:8 a=pGLkceISAAAA:8 a=r_1tXGB3AAAA:8 a=iox4zFpeAAAA:8
 a=7CQSdrXTAAAA:8 a=mpaa-ttXAAAA:8 a=QX4gbG5DAAAA:8 a=ZLGELXoPAAAA:8
 a=P1BnusSwAAAA:8 a=zd2uoN0lAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8
 a=foHCeV_ZAAAA:8 a=Idd5WaZmN1QeKTrTtQEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=ST-jHhOKWsTCqRlWije3:22 a=f02Ha7HRcztGgdyUxOxW:22
 a=t8nPyN_e6usw4ciXM-Pk:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=CFiPc5v16LZhaT-MVE1c:22 a=D0XLA9XvdZm18NrgonBM:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250060
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 6:38=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> returns -EINVAL.  The real implementation returns:
>   1  - device is active and its usage counter is non-zero (bumped)
>   0  - device is not in use or not active (counter not bumped)
>  -EINVAL - runtime PM disabled for this device
>
> When CONFIG_PM is not set every device is permanently "active" and
> always considered "in use", so the stub must return 1, mirroring
> __pm_runtime_resume() which already returns 1 in the same build.
>
> Returning -EINVAL breaks callers that test the return value with
> comparisons other than "!=3D 0 / =3D=3D 0":
>
> drivers/gpu/drm/i915/intel_runtime_pm.c:
>   if (intel_runtime_pm_get_if_in_use(rpm))
>   which wraps to: ret =3D pm_runtime_get_if_in_use(); return ret > 0;
>   With -EINVAL the wrapper returns false, causing an incorrect error
>   path in the GT fence revocation code.
>
> drivers/gpu/drm/xe/xe_pm.c:
>   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
>   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
>   returns false, so callers believe the device is not usable.
>
> drivers/gpu/drm/gma500/power.c:
>   return pm_runtime_get_if_in_use(dev) =3D=3D 1;
>   -EINVAL !=3D 1, so the helper always returns false when !CONFIG_PM.
>
> drivers/gpu/drm/imagination/pvr_power.c:
>   if (pm_runtime_get_if_in_use(...) <=3D 0)
>   -EINVAL <=3D 0 is true, so the driver always takes the "requeue" error
>   path instead of proceeding with the active device.
>
> sound/soc/sof/debug.c:
>   if (pm_runtime_get_if_in_use(sdev->dev) =3D=3D 1)
>   -EINVAL !=3D 1, so d3_prevented is never set, corrupting exception
>   debug accounting.
>
> drivers/iommu/mtk_iommu.c:
>   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <=3D 0)
>   -EINVAL <=3D 0 skips the TLB flush, leaving stale IOMMU mappings.
>
> drivers/iommu/rockchip-iommu.c:
>   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
>   -EINVAL < 0 triggers a spurious WARNING on every call.
>
> drivers/media/i2c/isl7998x.c:
>   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
>   -EINVAL <=3D 0 causes the driver to always skip register programming
>   when !CONFIG_PM.
>
> drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
>   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
>   -EINVAL <=3D 0 prevents any debug statistics from being collected.
>
> Fixes: a436b6a19f57 ("PM / runtime: Add new helper for conditional usage =
count incrementation")
> Fixes: 3b85b7bcccf4 ("drm/xe: Fix display runtime_pm handling")
> Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance aft=
er fw exception")
> Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL79=
98x")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change in v3
> - drop tag: cbb819c363c5 ("media: rkisp1: debug: Collect input status by =
sampling ISP_FLAGS_SHD")
> selected PM at arch config
> - drop tag: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> selected PM at arch config
> - drop tag: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime =
PM logic")
> guard by CONFIG_PM
> - drop tag 727538a4bbff ("drm/imagination: Implement power management")
> depend on PM
> `
> Change in v2
> - new patches.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Alessio Belle <alessio.belle@imgtec.com>
> Cc: Luigi Santivetti <luigi.santivetti@imgtec.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Yong Wu <yong.wu@mediatek.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Dafna Hirschfeld <dafna@fastmail.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Michael Tretter <m.tretter@pengutronix.de>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imagination@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-sound@vger.kernel.org
> Cc: sound-open-firmware@alsa-project.org
> Cc: imx@lists.linux.dev
> ---
>  include/linux/pm_runtime.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index de9e7518ecef2..1d983fe55a16a 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -276,7 +276,7 @@ static inline int pm_schedule_suspend(struct device *=
dev, unsigned int delay)
>  }
>  static inline int pm_runtime_get_if_in_use(struct device *dev)
>  {
> -       return -EINVAL;
> +       return 1;

This should be return 0, as we did not bump the usage count.

>  }
>  static inline int pm_runtime_get_if_active(struct device *dev)
>  {
> --
> 2.43.0
>

Kind regards
Uffe
