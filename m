Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B96BCA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9D410E1FB;
	Tue,  6 Oct 2026 06:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B7X+CnpF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmCfiDHf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CE010E1FB
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:55:13 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eFLP3661549
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 06:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sbn3DjeD0b28+scrBbrQHJZ8dt/yHM5fg8UpcUfPY8A=; b=B7X+CnpFMN2kF6O4
 2LuaNFhGeQdGse7uwpFrdvs+okvMGfOYi/qOHGpdv69pcgAgZS78ZdMtb4gK6go+
 664uyhvbbfRBULAIg6ojlU4hjZKjnnuA2raYkcF1Z5pWdoJJAFtrb8ZzDoW7d0ck
 BnlKEj9UpzgrWQ34V2AfdY35PD9esRKMD+vF2Vgxw3A9KFOTveA9WiY3TnS097Hc
 w55ev774PB2AMt3kCf2hiH6NU1+cvRhBMDH/cHJav8wNfqc8+DZlgvN//5D0CCrK
 AdLps5Cw3FN/j/Ybv8fKgtOSh+JZUaEZ7YTjwim0sIZtftfM8PHeElOoj0tRT6Ar
 +xBqUg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4j1nt3vr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:55:12 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7c1216e7d2dso2380268137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 23:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791269711; x=1791874511;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sbn3DjeD0b28+scrBbrQHJZ8dt/yHM5fg8UpcUfPY8A=;
 b=ZmCfiDHf/BA5BYmwcJVRFC4zDcSncHQrZh7mXa+o7dY4fE+L4/jxqqX8ekKdTuUL4H
 HaDqPF0VTtH65q2iLKKKApW+wXiR+Jo4koCSwnAnN54/cgbSDDATnNGc25Q8ckk2xwb2
 6N/fiEpZg6D5AMVFvfDAA4e9zWsR8dzqyg4fR49kLUbO25Oy1FZzpiGl1NaeUBQ914Yo
 8JtYWGe4ln9eQI+QKCV651nLLD77vSSbA+HlJTUZF07oXXtbLk6NTWkc6vOLv2iXRQK7
 cufl/Ft5glJJ/QvMWy9bdCNDPUSLsPJ8P5e6pDaZmYYvVAZ76IOUjHa+qUwKZaPuEvSY
 ZePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791269711; x=1791874511;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sbn3DjeD0b28+scrBbrQHJZ8dt/yHM5fg8UpcUfPY8A=;
 b=ibyO2XKzhIKJVU0272ABFyGTnxDAbdNDfom70515FuPu37R07Jewq+OeNG6WMu6WhK
 krUhlq0W/afZ55HsJgGRCn+rlm7xX/MknZeaWrnXEEfJnDu6B06z8RS+fWxgqd8sa4CF
 nj/wclc/1SWPIpU2PzSOvnSTTKYlxihueOGfCTHVkoTHQL1XkuFc2SpyILHGJt9zaptp
 e1JEBbZ3AGqlIoQHQvUuJkx1oBVz8hz0SFvpT8w7OTjhgkImwQciPVM2s7X3BmxDQdif
 pjuKvLJa2oeGdFJA8DztkxWPWefEiONZDEscdWxefI6K/1q9RYv3/KTgL3/EqFHC7ivS
 XLDw==
X-Gm-Message-State: AFq9FYKnGCHdQEhjEKewVtzF7Bd9eh/UB4BFwEIDUEX/cuE+DzSwwVq/
 p9drGHyBB/M07dmjTi/HDoou6nNSPVq3NQKEMfix4jS5Xk8PXlqM6mK4NDM0jQIUfqkkvufDzl8
 iTj1j904JVGvUpwF0YUJzerr7AXXadYEX/afIYV/gWtFgfRugQw7iEW4kL+AHGvjl87deR8QdGb
 yKsEjeOg==
X-Gm-Gg: AYBFou1f78QuaKIsmD+ihidmcsJnzUW1xheccN2QTXc5L6MzdiXEb0r9JEk8DRvDueQ
 JJg9VDJwLIgsMcztGc+s2Ig6SzuzzdjY6t1mXg6ZsydfUfPrd/5tQ6q2anHJJITXIaVae8aFSDs
 34uzC7UWcHD1tNQJsPnq4kVdaoHhhKYiRVyNdn6iZnF3QhGck7ezDrMHB9YQH3vg5Ox6TqU//AP
 dSr7MgKryoH3tI9iKcz9QmZpmjUi/sUvOqEFUzxcfHUNYMTtzY7F3CKjsfOCRBVUy0ZPKby/Yqx
 IS04tcy+3O2HKBxqJA/+ohA1SoD+vQsTdGoaMbci+O4DEBCwkn/y4T0nAjtuFDYu9y/z6TifpQn
 fuzvs95W2VKKO5Qx9YNZUU4CHcPbnbEsf/6k5v+KDtbb+m0g+EQR9RN8FR7kDqcD8jqvAkqd5Xj
 ivR1awg9QLkbP+
X-Received: by 2002:a05:6102:dd1:b0:7c2:14fe:33cc with SMTP id
 ada2fe7eead31-7c87c945cb2mr82061137.31.1791269711493; 
 Mon, 05 Oct 2026 23:55:11 -0700 (PDT)
X-Received: by 2002:a05:6102:dd1:b0:7c2:14fe:33cc with SMTP id
 ada2fe7eead31-7c87c945cb2mr82051137.31.1791269711089; 
 Mon, 05 Oct 2026 23:55:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e303fabsm52162651fa.21.2026.10.05.23.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:55:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org,
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, lumag@kernel.org, robin.clark@oss.qualcomm.com,
 valentine.burley@collabora.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/2] drm/ci: retire limozeen job and add
 wormdingler-rev1-boe
Date: Tue,  6 Oct 2026 09:55:05 +0300
Message-ID: <179126968605.1110179.12812564062301444314.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616115410.325837-1-vignesh.raman@collabora.com>
References: <20260616115410.325837-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX4GO9LULgLY+0
 6rwt6ihXPsMgsfBh9Oh5XM1TNL0fb4fk6SPiMjSdjUQPjOxg3avuSK6XZ+2aFlYPGAVTVdUoln3
 Mfar6QWd2naiR8Vy90vudZh5B/6tLUo=
X-Proofpoint-ORIG-GUID: C7mMTXifVsYxDfWqyG4OkLWMfLxO4vkI
X-Proofpoint-GUID: C7mMTXifVsYxDfWqyG4OkLWMfLxO4vkI
X-Authority-Analysis: v=2.4 cv=F4fC5ahN c=1 sm=1 tr=0 ts=6ac49b50 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=fbh3NUXcjvyNh3hXOmsA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX/EjDeZje/trG
 fT+v6VlRZE9MXLF1xb2aMQpMpW0LyvUlneSlAbZQTM7GR6p4N1sw5nSzHS4cOOlh5RDeJhue6H0
 5XUW86rko6yiYW2Bh5/5BP98O7KYhbkDplAovpz+1zgaD1FGUL+7bN76tRH1KsTus+W9Hw/ieuv
 FjxUqSW2Zdu1jFWEN9Q60ayLjOutzF+Ct0yN1/JPlPB+eJF3GXoxNdDNyGHVbk7rcF4iPIizYtv
 Of6rIgl8EsTQ7qpt2DE7J8CMYpJHqdOJ5DN3DtRNi8d+92rejlnXAbt3ev0KU0v9SjYnNJKeyoy
 oF7F6ZySWmfW4KLDSXkYUjInHGVHRdvFm9poaKpZofa/pB/M+7mBpxkeUEKo4nb9jkxgNnTRW0i
 svVlugRrPxOOXK/OaPUS8+gjE/vG94YK8gyOjbxsFj5lmiIvm7BzfaptpQ92xtT805OVwLZmV7s
 b2fZV+jheOYcTAq1vuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060027
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

On Tue, 16 Jun 2026 17:24:03 +0530, Vignesh Raman wrote:
> This series updates CI coverage for trogdor-based sc7180 devices by,
> 
> - Removing sc7180-trogdor-lazor-limozeen job, as most devices in the LAVA lab
>   have been experiencing stability issues.
> - Adding a new sc7180-trogdor-wormdingler-rev1-boe job.
> 
> MR: https://gitlab.freedesktop.org/drm/msm/-/merge_requests/221
> Pipeline: https://gitlab.freedesktop.org/vigneshraman/msm/-/pipelines/1687201
> 
> [...]

Applied to msm-next, thanks!

[1/2] drm/ci: Remove sc7180-trogdor-lazor-limozeen job
      https://gitlab.freedesktop.org/lumag/msm/-/commit/ca9ee204e12e

Best regards,
-- 
With best wishes
Dmitry


