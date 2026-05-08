Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A67ECD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 12:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECFA610F474;
	Fri,  8 May 2026 12:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oZrz2XsQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QENXwm+l";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA54010F474
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 12:14:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648BleGr4069446
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 12:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=In49/1HCdY0mp+ShQ8tlA4tT
 XudR8PGllAHcd0hZ7Sc=; b=oZrz2XsQ3iZv6f+hTcT7U1Ab+sy8McNKW7I4YJwn
 0dXWt1F9plOou+Zdx1J1ZtDG9/tjqfSqR5D8G7GzTCyXgKFllC3KKBCWq7SLv7Kg
 w4b3BEo3G/CxY5z9B4c3NFZFVJ5GiUkKs2RA1l5c7P1QfJtAZ1AO7ZEd6ggzK93J
 ooXS2FD4/P7M8aAvSghEnyo/Dluo7JC0sy1UvjLlJrDm4BRydEd8VQqsYiUgRZCQ
 5CV3ZTeSz/GZ2Lves8D6V7ekk1CSiwtOmIGdR6TK/Tb+8GZNeAX9Nh8G7CNzjSz5
 Ie838JuRUlZLStKHN21xlZJhKqj0iGbF3D1SU1AmtRek+A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e12sp2v4p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 12:14:39 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-62f30279e90so1764655137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778242478; x=1778847278;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=In49/1HCdY0mp+ShQ8tlA4tTXudR8PGllAHcd0hZ7Sc=;
 b=QENXwm+l7Lx+KgWMhiD6VbbuXpXFlutv5MO4yslpik72PkHScIuTgpWgxZfhudH7Ca
 gQw4xNbpzRTu613GGLhwsuF/WnU9f8b1JJnblRkER40pU8ELlaDxWp2p2x0wMcJxm1Ud
 Jf6jCbO/LQraCiPEx+xXDjc214izq65xBrHNgqPTB4uMcTuKBOWRYMZuZeMhjo63D92D
 jnzem4VitXliW9ov1mIIyico4aN31cUeiVNl6X9ScCFe6u5GUDdpnz9xh5gmw/tu7sKt
 86pkuFcUNtQL6QXCE/9UPwXKRFJv51JuDTCr9yPJnz4I1I3pfgPvWrQS+dH+/jZ0SR2K
 ca7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778242478; x=1778847278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=In49/1HCdY0mp+ShQ8tlA4tTXudR8PGllAHcd0hZ7Sc=;
 b=durHtuY1kU+vMLXZUso67OqOTbZDilQ6I4aHGhh/iwEpYUAij5LDWy42bgZcoZWdga
 Zc77rzNk9NmSdDivRKI3QwBJIQxDFWPhSs6fguHDIVOdGCSKJy4jjnwo+wWY5TCOemut
 lIKye/MWaHs8iptJcN30WIT7BOXW0a17/twVkJ/LMuNqtJbBd2OXVwoMjt869x9+lOrN
 deTDjwGrn0nUXztEsNfLPJN9a7kVvf9HcHlgq43gWia0oKCq+ZyuNkfXH7z9RaC2Sbm/
 W6PgpuOpHMsr3IgH40vDD/nAjtyZ8VOpHdqUhRMQoYzbdWhnQPgSH1Lx4EbBSsYoCYDj
 B4tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NOAPUsqLjWeojOGl9krRrCgxh2lWJPeN7G4fzFSy65ltZvkAeaLFMtsWdhQj+dWpxpt/WU3TkfoE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzCrsZCvgYwc5UYepf1hz8Ye9qdCKU3RMexxtgh5/Iy9aqkWeR
 4v+RJ0evl+vMyXSZzwYOhi9kZhYvtlhjbw8PvEm2+hCcm9KkRKxspGssrUqERknz8KwTzU/BUde
 WYMp9IbTf0KklalLyBPXqdtbFLGi3sI+u2e9bldmUxOr+hNqPhHC+FuTnb0VVyQLnIx5kwt4=
X-Gm-Gg: Acq92OHiEBiDKJC+rY5WUI2XdPo6RpqDluPoiM3FYlCmBOlSwYt+JSmZsj2TbYN7YrC
 TQ6VIN98AiW9T+rmVNJvnl4Z5Qd0HmgLE3Xq/uogapDhc3Hpn96l97zxcD8cLyE/LMOzebGuP0Q
 tvvcGPNSK/IgCYlCQZhKeN3Cpha+lc499VfNdQKGXnpFLGBsoIKo2xE8Is0pP+hKtp3aE+kDCfT
 qoXxMAzaI/w37mQ6LP+zHY88MEoHN50BuX4Y7yhFh62y/fNcfh1+flLTwUfRzGfbQkN03mYvgq4
 V+mF2e6SrOEr/Tj7QpkVkCRcbQ6Z2CS2BAkn6kLxbBxDjv4fBaWGDuRg7qSYakRf7z1SKid9U3A
 WlUgVD6NqGVWxklPBQ3CjbqhTIUvZ4Aoqz2tGPN6L080QiTkqfYIavd+rMEAT8SIZc7yNS4cIUL
 hQuYdCYVY1pHhp6PAMIYIcxch80rbQUlEgKBk=
X-Received: by 2002:a05:6102:dd0:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-6313eb08909mr674059137.24.1778242478137; 
 Fri, 08 May 2026 05:14:38 -0700 (PDT)
X-Received: by 2002:a05:6102:dd0:b0:607:4fde:1921 with SMTP id
 ada2fe7eead31-6313eb08909mr674046137.24.1778242477632; 
 Fri, 08 May 2026 05:14:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a951d2f2sm478339e87.28.2026.05.08.05.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 05:14:36 -0700 (PDT)
Date: Fri, 8 May 2026 15:14:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Junzhi Zhao <junzhi.zhao@mediatek.com>, Jie Qiu <jie.qiu@mediatek.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] drm/mediatek: hdmi: report jack plugged state from
 bridge enable/disable
Message-ID: <mv5qeardy5xy5657hb32ewkwg3gmgll3kow4xuhiklswnmj2sc@mhncl5reoqlc>
References: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
 <c4d62fc2244fb72207855c5a366ff10fad419f2d.1776265222.git.daniel@makrotopia.org>
 <lhxivpwo6aq3ehgzsnkgxnqis5tptmey4dtbhaokyckkl7ghbn@dzaj225pnpk3>
 <afyUfcr8HuFs6EKF@makrotopia.org>
 <v343uqdgy65yg3lm7rcv57mlpkudqxrnori6lnunaiiewakhyd@wnxkqhhwwvgg>
 <af3Ml252DaeyXzwe@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3Ml252DaeyXzwe@makrotopia.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNyBTYWx0ZWRfX0IhXssO73q3V
 IhAdlAxV3ae1bOiJeIeLrrIgNOySLklVB4v2PVB+fnppJblvrKNj6yYVWhutg7myhDeiPqK7txo
 VeVaOBrTlGZQXxTva1syDjQpa7IbpZuSzbdpIdDIX8S7eI9YxHgP6O+d9lbC9xdvAXBXqptfVrk
 umrxZFYhi5HD/4YRAQuUID0VEjOJv5w1+URw/DOeRArfYdW0Mn67YUNWIh2O8PoJrps8RLafnce
 s38cdhgJKxBcddiUrHjxbbn8xWNmQFDtW3I+00TJBKTbKal7Di6MvTG+AI1sVoOzKs1CcV+Ffve
 9Tk7oQ/dxQFLGP1MGdxFr0XPDqgawZ4DTGcEJkadriw+jNGaxf60Xg8i6GiKz6G7z1fYMa8uysj
 EZ+L5n4z3c6FSJeJXXiaIKNvV3BAJmnrjifmaKxuHaBDC4RYKg6T+Yr0nk/tMWzND7AFG3x82eb
 fV0jsqYl/G+k4sBG9uA==
X-Proofpoint-ORIG-GUID: gHFrU4GcVM5XhoAT6CRLYIX1tMZrEqu8
X-Authority-Analysis: v=2.4 cv=Wu4b99fv c=1 sm=1 tr=0 ts=69fdd3af cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=nwvF3KZO1n6Oi4RS03UA:9
 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: gHFrU4GcVM5XhoAT6CRLYIX1tMZrEqu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080127
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

On Fri, May 08, 2026 at 12:44:23PM +0100, Daniel Golle wrote:
> On Fri, May 08, 2026 at 02:29:29PM +0300, Dmitry Baryshkov wrote:
> > On Thu, May 07, 2026 at 02:32:45PM +0100, Daniel Golle wrote:
> > > On Thu, May 07, 2026 at 12:51:56PM +0300, Dmitry Baryshkov wrote:
> > > > On Wed, Apr 15, 2026 at 04:04:16PM +0100, Daniel Golle wrote:
> > > > > Notify hdmi-codec of the current sink plugged state from
> > > > > mtk_hdmi_bridge_atomic_enable() and mtk_hdmi_bridge_atomic_disable()
> > > > > via mtk_hdmi_update_plugged_status(). This matches the pattern used
> > > > > by dw-hdmi, which invokes handle_plugged_change() from the bridge
> > > > > enable and disable paths so that ASoC jack state stays in sync with
> > > > > the actual sink presence across atomic commit cycles, and not only
> > > > > on CEC HPD transitions.
> > > > > 
> > > > > Userspace audio daemons (e.g. pipewire) rely on the jack state to
> > > > > route streams, restore per-sink volume levels, and recover the last
> > > > > used device after a reconnect. Without this, those transitions are
> > > > > missed whenever the sink change is driven by a mode set rather than
> > > > > by a bare HPD event.
> > > > 
> > > > I can only hope to see mtk_hdmi to migrate to DRM_BRIDGE_OP_HDMI and
> > > > DRM_BRIDGE_OP_HDMI_AUDIO...
> > > > 
> > > > I think the correct timing was discussed several times and the overall
> > > > conclusion was that the correct time is when the actual HDMI cable is
> > > > being plugged / unplugged. See the discussion around [1] and the
> > > > captured response of Mark Brown.
> > > 
> > > Thank you for bringing this to my attention. I'll follow up on it.
> > > Meanwhile, can (independent) patch 1/2 already be merged, or at least
> > > get reviewed?
> > 
> > 
> > The discussion that I pointed to suggests that the patch is incorrect.
> 
> I understand that patch 2/2 is incorrect, but (the independent fix in)
> patch 1/2 as well?

1/2 moves plugged updates to the atomic_enable() / atomic_disable(),
which is not correct according to the discussion I pointed to.

-- 
With best wishes
Dmitry
