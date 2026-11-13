Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F3606C08A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XLgYD711;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UXNEEZ6m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C5F10E146;
	Fri, 13 Nov 2026 17:47:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6EA10E533
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:47:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRR39738055
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=; b=XLgYD711Nb6RdnRZ
 pQM/51Q183vY/GeyYUbr8tGR4RkZZkYV2YZLlpgqyAn6ep8vMEH3k7k5XmsTr6Zm
 dg4JtobSMy2N/EQQcfrNKmRJT5MRHku+6LyZ696Kz4uqWEnfZDpGBQIiY5yMuVtq
 /vvumqxB+tt/zkmIDA6XX7vwN/iLx/oPCpTqQsI6KcS5POxjqi3RVrrQzff1UhCu
 qb8l4Ow38i8jqlUuWr8EBtw+dWgLGU2bfB1M33C6drxYHw5GpzI/bDQRlKe0GEuI
 4xveG2iHz8mEJb50e8UCyeyD2PMSmP8dSapmmAeePBNVReEyHsGi+9Eo+37VDu6M
 5P6New==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37jmkx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:47:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ed34e33913so8009255ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:47:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592034; cv=none;
 d=google.com; s=arc-20260327;
 b=Mbxss39akwApRe81zp8rWHuI2fApoJs3nin++HrONH7R9fm83TGYyyZLhuAccLkL+x
 9yEo/33kwsSRA8K3jWfXcT4Bb3lO9d3eCZTIh7Z5lGgVcwbVmiHtpf8/gkZ1Vhe4W8Wf
 vjq3zSh3lTbz1fFe59TiG6pftAS/uO4CkQu+o71PS66Fqp9+dn8cLP0TqbVM8eL2viIj
 Idh6ofdzlRODGTPSqcYAZZZiWN++6TTbQ/xfIYtc2Ocoyz0W3v9MZrpSPM5weJqmkmE9
 9o891nPIVXsi/7MC4TL8QEd7J7C0tSRJ44Hg4SeszNlVBEhkRRN+9uVUXee3UuKm60oH
 K8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
 fh=SeFpT5LuizweuZXCted6fCOfer5q4hWlWyz4T+bV/GQ=;
 b=iR2nDBcbG6KqnsDNeULym8rWSKWe+KuBl4N3wwa1Dc4UEqdfS9jBJ/tGqWhMR2AReF
 66As/jTSKlEBfvOEhCm/r/cQhAzwVUHc89t8+u+f07pEDtEgad0lrrBJkpUybI3cYV5b
 JM3Yjd47qzs8FgpMZQDW7ayxAr95xTjbfKz4nYgp9K6w6X33VC08DhRucDmVBqdMiGfl
 fYMG9kKybzx0ThHpGjwIat3yQj97W+LA8/++cwz/1hbwT90lb2Ut2qudGho4gvief+Mt
 +NcmCf2aaIin5QWIUuIzY5XmNrTVRz37IJsolMrKJ/VIvf72JaZEORXTHxtaIdo0i+8Y
 CAlg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794592034; x=1795196834;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
 b=UXNEEZ6m96bha3bqdVGrFG1/LGE7CayUzhwBfJk0uJqSuKqrQLgZkyMy2UH10XE/p+
 KxMlUyiRRjXgcHqTzE4oC9Lb247JLV+vv1VKJANzqQdYki3WokJm0/DG6issFtHQ9fLS
 CKWmR9uTVMP6B4nPApuPfW61h97QKfnJ0rpjxufaS0pvRhZ0WyXw///nz92ZqMCv5Xir
 SM7cGWzm1bvGFIaud26jpjuFNdvDZUOVDa3jUDu8St/5Ro5W/kbqBRdMKpDTQzDnl2Ev
 OLa7bfMKtWl1EX+lgLyfGAq8PHYdRzSLMIM/kd2Q+C8h7gIZCQFGb434Zgk9SeVOfV6l
 S3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794592034; x=1795196834;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XUtAykq3hDRsL0/US7WOum9GrsDms9AB2V3NWupV8pE=;
 b=H3VZKbkGIPxoP9N0uZzNH9U4u9ruZMjtzpAGbtVWJ9ND85mQtZpk9HDmMVj3MpCQRY
 YV1Akyfb64iL5XO4CIR+vNK8OGVT5qrCJ2d8lUSM2Naa+SBLgdi4i4kLSqBaDQQnLuPe
 WXQpBLlBO9Tw7fL6oiPX42XTBfGcYGvMWYhNn9LzjFtmt00UdIFo4zv1drQn2Ja8GJc4
 XSv1gt7o44AAuLepAHEUIfR9DELi9DqAaXcLTiUbIUFkqeTuiUY8NTJqBEoOdNTgjuDE
 IRlGbLR4nlh3PUHIn+IeTs6Tshtpblk5zU0n8V1rt+ORJ19HpWw0B4C3kfe4sbqmNnVS
 IX3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEHwEw25cVw4rFjlJJ7IhCiZRplml+FJ/cJ5NSehBD5n2aXTjOuLBqnr6bthPWpsanNKpdg/vXhAwE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8CLNWQbFbkRcjXVCXKctQoHA1VNoDzGa5jOeS3h30jvMT1wWGg
 ue80TDwL02DS91FcoQJJ/VXJhRL8eb4EDO+Ju3BGAkzKxWFyqkq+J022cK/QplibXvmmsb9Dd35
 Tp91PP2eqCHvcOKYgLRnpSQuynDH0VEdczIFjgQjhlr/LzuGOTNpuxxhs8l810KUD49fzEY0/rF
 217JhTkO3VwKrjpuioyygf2hHqieDDGpnjR5SsvDBaEZ4eKA==
X-Gm-Gg: AYBFou0X99AIZd2Tqoznl8qmYlisuQLBbkwAd/5Zoui6VAdRqeZ2e/frsCzYROKC5Y9
 vA0ZtJ2cUtoqkDfn/RwVEat3Fj/tzlha/0q1AZkILIP1e7qxR/WyPPnQbC2BBRMVvJ8cPm8P7eP
 rx/qDrqZt7lrYIVX5n5wnpyG6ir3tBmLrvD9MDCbVv8PtbejTlwvWzBrNBtA==
X-Received: by 2002:a17:902:f603:b0:2ed:4456:fb2a with SMTP id
 d9443c01a7336-2ee0dedd363mr31379275ad.36.1794592034234; 
 Fri, 13 Nov 2026 09:47:14 -0800 (PST)
X-Received: by 2002:a17:902:f603:b0:2ed:4456:fb2a with SMTP id
 d9443c01a7336-2ee0dedd363mr31378845ad.36.1794592033770; Fri, 13 Nov 2026
 09:47:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <6777074.j6PcuT4dK6@diego>
 <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com>
 <20261112072146.41218-1-gahing@gahingwoo.com>
In-Reply-To: <20261112072146.41218-1-gahing@gahingwoo.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 18:47:02 +0100
X-Gm-Features: AclHuK_xZYTfne11hVPWnloCpcRGvh8w3tWYpN49I_tY52oUY-lip7RnFHUhpQI
Message-ID: <CAPx+jO-KKvgRS0br-3QGh6Jt4efWJ+A6YoRZKFV_bcfB+8sm6w@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, finley.xiao@rock-chips.com, shawn.lin@rock-chips.com,
 tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com, royalnet026@gmail.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 alchark@flipper.net, leonard@lausen.nl, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX7VJhpwKSFXko
 UvJ/ZJo6OJ8OHKheY4owx/NyGAQojjlyJ324IAkF+SwLCPfRmIIYpTFKU64mYzxoJSbvRmJYUaW
 mFJlEBj6l/Gyte16X1mQDz4gGt1VbeE=
X-Proofpoint-ORIG-GUID: PN76b9F3Sl3NRW90QG0mwFlvSS70VC27
X-Proofpoint-GUID: PN76b9F3Sl3NRW90QG0mwFlvSS70VC27
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3MCBTYWx0ZWRfX9iuFsoK8gmAC
 /V2d8N/YA2vmYNTk3sFMfIbykCRquGXc6Slsi1tvETa6urj043qJJHDTyB/6m4ucZMjI1US0R5/
 Exmk8OxIlUiF7Ugf9IA6Ax9qrju3IaVfZaNWEFeTFpaMaI4XMCAUyFvStCG7X2SHv7yZNp1I4jZ
 RxEItncfRYXmVt9vFVD63nra6o7rnCzFnJqUoeXmhmpCLgrP5zL9sLeHEYErJl8cRNLUDtcyzD2
 VLHkr7nv6OejppX5FV9A4OilG5FiCu9yHSIfYuife/IUvvx0jMqtVnhLOe0+iGcWT3F7RQhh9iT
 7p13ystuuo9wcO/1BDnb0p9IXp6MMJNG1FBqXt1XC1OGSggJtz9gfTNtto6pQ5ryt2/7yg9JlPa
 awYJhywQs3dTOUUSdo3RVwvxs9MZXJFTBtCELSstus3AcMMyoJdUXrdc/4MJMcvcsYGAQmYdlsa
 jI6B7uNOpfoPSdWtE0w==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af74d23 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=s8YR1HE3AAAA:8 a=9GNsruGHAAAA:8
 a=KA_qeCUQCZmkxMg8J8kA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=jGH_LyMDp9YhSvY-UuyI:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130070
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 8:22=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Thanks Ulf!
>
> On second thought, I think it would be best to drop patch 7 (the
> binding) and patch 10 (the reset) from next. Once patch 10 is gone,
> patch 7 is no longer needed either.
>
> Finley Xiao from Rockchip pointed out on v16 that the reset is not
> needed, and testing on the current code confirms it:
> https://lore.kernel.org/all/ca90a994-70cc-410a-902d-5c4c0aacc9b7@rock-chi=
ps.com/
>
> Patch 9 can stay. I will send a separate small patch to fix the delay
> table.
>
> Thanks!
>
> Jiaxing

I have dropped them all, let's start over! I needed to apply a fix for
the rockchip power domain driver anyway, which caused conflict with
these patches.

Please rebase on my next branch and submit a new version.

Kind regards
Uffe
