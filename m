Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D856ED58CC5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 03:53:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E6510E358;
	Mon, 23 Mar 2026 03:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmEDGuXR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DvpGHMwl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A18FF10E358
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:53:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MDUJNL930002
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BRaKz/q5ql6Zi63D2ehAc+ss
 ZqrmS3p79ukhpAexd8M=; b=kmEDGuXRymGHdsP0ecxqA9+LdWHaJO/4NtUdWjho
 sEphS0i9NpVaEs4FEZ0jMeh3zUSxajqlELWcz8WhnoMpno0utxKRQ/zskgCZLk7o
 1l8+UvnjA4qSyOpJ0xqssG9viNSef6H4s/rv7EivgWypphIhKbGtA0uGs6hwAFOG
 YoMpYclPKWX68qZH3vvZtouS6mEe1r7c9FwRTNetvSIKJPCfTl8brb2MGaX//q0i
 N0xob/f8vVbhPVfU1J4zFFRV+M9vhwNGj2LOpvf6t2w41b3KZvSlWEMfMKQRkLt/
 4VqqXVy5KPu5PPCkkuOOev6pTbEroXSTn8Q5adpsN55JTA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kdubm7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:53:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso34147241cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 20:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774237994; x=1774842794;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BRaKz/q5ql6Zi63D2ehAc+ssZqrmS3p79ukhpAexd8M=;
 b=DvpGHMwlxn5ELeouhe+7tfWaXyyxuvcNr6DhZxQyJ0lAV0ltD1/2TCWk8qmLkH1+r8
 5qgv+fv+38Xt4BBmLLtfC5dZra7ch2bqIGmaaQ8F+jKEnhRB/fAc+/u6PmkwtwJg2sFF
 bii6nCLTDFa2cfvrHWg1GRmHy8etQVhOYObgqKaDNQU0fbBhMM+/eNaoKMXQnciBQ/po
 KY6jNmuVXYti5MhMVh6ayZ1mJ7jw3BVC41XAkW7ULA4OR6w3oIhDeM/0JpimdCgcNbeO
 nKqDvz5YJjggveuxTnbfCYPUxPqYnKgcXaVn1IRM/RhjuEW7GUZrU2TdoSQ73Jqrubyj
 kzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774237994; x=1774842794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRaKz/q5ql6Zi63D2ehAc+ssZqrmS3p79ukhpAexd8M=;
 b=Td/sQGsob+lWp0QG2s1J4O7KmibFmSuikhZyE4c6l4cOUlsR613w8Wb6o9hunBF9T1
 /XeShX9WBve518drVZ13ZGmbiswZQls4QqjDTtyDbSKPM6jlGiuGYV1J+NNr7GcxVj2/
 0yYzrmaukQgjQm9cQg7Q+6l1H+wyIzRKAe8qE2U1VaaO1yobuzPe/3iqGk51F6U10TFO
 a+FM3NSnMK2V10ukRvWY1VshBST5dFqkpWTSyNFfcCOONDow6tf517mAFOdNPtKF0GRo
 CvnuSmFAwKGzWpdPBtEKzkh7Z1mvxzS+uLWc4M+X0HkQAq+OeKiP4nHrYUonOjHfAcrP
 1AXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcMBx68gnrePOtGIngyNLAQ0U4DdArsSr0L8gzuuFxlebam8Ci1JgKpIgzfcM4r4F6GarX2JwAo4g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYYsdTDxSIxic8MSRTriQdUxGki+XfVoAqYrh10kskg3bTjdHV
 F4bVyqHBDMUpZde4WMzi8JKZbEaOUcJ55CxjTawY+/A9C41EulH91HwQ/2HJ7idP79TDz4g0xGS
 wT/zWviuAU1bmR6CzBKbpQM5Fnp+Y626y2ZSDesE9QatSYf4jL8sFQG/DnRwB4S0CcbpSHz4=
X-Gm-Gg: ATEYQzxB4vmNT6oGgfvhHezO6MrCvXFXACSxwdxskShVlhE1nVwxv3FDYBF0mjMLgXo
 0vgcCIrx7UCbQ41YMEKpcTHxEk+06gkMPeT9BlP/Ccni7jnXhptsIY83kzEUmqlDNFrJZnqxGgS
 3CDFHV78j+BXwIaJXOJXcF4W6azPGjbgsPfJVpfi1vVDSdd50Hl5Zu/6rX+0I6j2cLjtQoVriJ0
 aR7BYuk87Pe2O9ei8QBBqaG2uGqEzHSe1Oq94DkNKfD/DqODAA3o0Y+43DGZ17+Q2Tcbb5sKo1N
 NEMdh24Zargqp173DXNGMa0NCaLXlxZRQp2HgXR0du93FeE4lpDn6x4yK4fr5i3Ki2crBxQiOjn
 vQrcV8vpAsQjxol+pwZV1cWQ65J48EDhQq7BemPNEIyvgq9UenP69Xb4sytT+Vn8GSnG8VtKFCd
 XcVBe9SOecO6hO3/QHYnx6Mb7Fhz3gGd3AC/o=
X-Received: by 2002:a05:622a:1899:b0:50b:50a5:d61e with SMTP id
 d75a77b69052e-50b50a5dcd8mr77271661cf.17.1774237994143; 
 Sun, 22 Mar 2026 20:53:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1899:b0:50b:50a5:d61e with SMTP id
 d75a77b69052e-50b50a5dcd8mr77271501cf.17.1774237993683; 
 Sun, 22 Mar 2026 20:53:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf97594bdsm22624371fa.14.2026.03.22.20.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 20:53:12 -0700 (PDT)
Date: Mon, 23 Mar 2026 05:53:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Icenowy Zheng <uwu@icenowy.me>, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/bridge: th1520-dw-hdmi: Fix remove() callback
Message-ID: <443mi7an5qyyjol4s2wen6oten56advyzs5sbxxl5tbdzcoork@farulzm4ygsj>
References: <20260321-th1520-v1-0-ec877197770d@gmail.com>
 <20260321-th1520-v1-2-ec877197770d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321-th1520-v1-2-ec877197770d@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNiBTYWx0ZWRfX9eqO8JwyL6Ir
 4Bh6KL6JKmPRz+Ms4a54ktXnBu/GXltVqTCtOzAKVuJRulI2W/3PtuJqTHDyvaao7B05/zQ8GAc
 zQ5eslroHJLOeR6N3Z8f2ujlwdHWc8FkpTEpheyOP3OIBc4szcm8XMtgL71f4rVWeIUA4pgBgg9
 ft0jGSxXJP+V9NB7VK5Dhn6I4rnZonqclAUem9LNNeQtl9CMwbJg3Ll/nfn2DaHLMIN2b4hWVfz
 IuXbeseqfRG10wHWPbFe+YyFOQ5ALiOirUomZ2AQDy7DWetLs5VgcVljPZxRPRCj9yC+nQYMZKq
 7DLAYOrAGssaOcrNpErWHacM+LCVa04d9IsuTcFyp2I884FP4KOr0lSafmTHlIW6BuEOLhFXi4e
 BpLUk63J+LQ5bHM7nFnPeMAPSzkStCrcBChT5FoesJtVtZcvNa7cKYZnZOV6QoNv7a7vesjG4le
 /NQF5YUWeJ8xTzrVV1Q==
X-Proofpoint-ORIG-GUID: v1gJl0mGglzBs7uur0GNsd-EDZaPqpuR
X-Authority-Analysis: v=2.4 cv=Q4DfIo2a c=1 sm=1 tr=0 ts=69c0b92a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ZRtV3Kz9z0tY375oaq0A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: v1gJl0mGglzBs7uur0GNsd-EDZaPqpuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230026
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

On Sat, Mar 21, 2026 at 03:12:11AM +0800, Felix Gu wrote:
> This driver stores struct th1520_hdmi * in platform drvdata, but
> th1520_dw_hdmi_remove() was reading it back as struct dw_hdmi *
> and passing it to dw_hdmi_remove(), so teardown runs on the wrong
> pointer.
> 
> Retrieve struct th1520_hdmi * from platform drvdata and pass
> hdmi->dw_hdmi to dw_hdmi_remove().
> 
> Fixes: 96f30ee0fb9d ("drm/bridge: add a driver for T-Head TH1520 HDMI controller")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
