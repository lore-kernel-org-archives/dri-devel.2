Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD91C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5845110E4B8;
	Wed,  2 Sep 2026 18:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bcs8whjz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZKWYjWb1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27DC10E43A
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 18:41:25 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682Hqv922104776
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 18:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 COk6vE2ve/I1mCw550knzyWX0nlFehDWi8Gm0jd9uVY=; b=bcs8whjzqR8+fxr3
 eGcVtbdu1rEc5uC3cCOJlNz2CeOo5VoDsWp9cmmFTwl2okzLeXniccQslCt9DErP
 qi/tQ86A4+XYLTfURbmgeuTQ30cQPRg3VHG/oAZjwQRVPniXRTzGcxVg+wA4Kf6Q
 t0wMKD2q7ZcVM8R0cSn9XnaxH+eJgReFWcJBYW9tzshni+d/d+uC2ZvAuvXWcGpl
 fNkdYV0bErSXtuNO/KGSxncOjxETQN1PgM+lnl5OTyCf/X91WKSQ0fwy21zBUweB
 R8cjN3FSgEbSol0Zldxhg26RIFMIW0hQylnQFquD5BTzQ1hTmxYHiK9Xy+HjExVd
 orhZPw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrds2sn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 18:41:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so2497223a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788374483; x=1788979283;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=COk6vE2ve/I1mCw550knzyWX0nlFehDWi8Gm0jd9uVY=;
 b=ZKWYjWb1mqdVIPHcOz84ZWGRF90HfsNPsq7W0E1ji+I6Lq4+lHhLMgeRt1KE3xOsRK
 d7yPgcE6SypE0IvwuZ5Di+hySwFcUxoLZ1uHDqB/snpaUbelQs+S/yyoU9f3c9KHskj9
 2sIon8U16CqvlRo4io1Q2GkGRbFKB0R/LXDxNNsxJDbmPLT1Wnn6dA6uX8NYmsWpAL8y
 VsDaYl4pdVE0LQfsVdqY0zVm1vw1UcN0ahVEdPvmDfbssAo+9rBy3aqjcQi4cwjGbHdr
 NGpBC8jwLhaqi7ld5PSLhlesKSnmyg9u6kAkhi4G7xfyJM3i0k7uKQ84rXlBl95fZr7J
 dg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788374483; x=1788979283;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=COk6vE2ve/I1mCw550knzyWX0nlFehDWi8Gm0jd9uVY=;
 b=seqLXF0eV3AwObW1xiCBSjh3pRfsVIFxtzTQ1LDsPxRqWiGURhPz8Z2z61N5pYbckU
 rxPqy/T8mUCfFbkM2T/5cB9XhvZEC9rUwK0woUdlQeQnv7XpljM/kT8BCg34i8bkCfXV
 H+zI2RDsNNZQjuMMCH1DwhdKWKPTlKHeO8Kjekrn2FavH17a18CxKslD9mjCMAfpGof8
 WDTtpyDvOZ6cl1VWfxaDo7igqP4ZrBCTjLK8za2YKTj4jYuZoDr6YzVqsjxoAyiSjAp/
 CWUtrWVnKWNmVmrkat4UA3f2HRKPl+7scP5nIo/iHX9xAoKQTRXGMDAhXAsh728GG18e
 H73g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuosfNwxcyqblgjEkaEkVlM6zkaY0yQ/Zc3XArSPCsMNO5d96t7ZQvJ7XqpIuHqVQDgMJYgLRrHvc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lMKDzg5Yxf4vfiy0PrxKG2KerDJ77Z39ksOhMV+Vj/QpUp5T1i
 YuF3NyBdoDu8+74liTgbspLpHpmktghTe/RKDQFkv1wieOP5Cb/lzFQpZwoyzIHK8os3zlwjZT6
 /g7nOAANZRmO0hepwUjYn13CAiUATdnk9fX+i7Xwkwf2pS17PDSdTJiHi9FuPFF0ljwCVnTU=
X-Gm-Gg: AYBFou1UsPihHFwYODOcjetTfnogNix2CnLhcjYWgMwp0Z7Groli5oTKJKUNfrSDsVn
 LqJjs7+k5Z7ydZmuY8ig2bs6Yg04wg2D1twrZ4WyqD5h+h38RhmTICmrPy602DxVEiMTgd/pi2L
 mdMld9DSPNsfsM6KvC+SKu8SDDO8eo0ncKxGTSZ2L+1CHBI8EtFvVNwp9NEbYI1kdTHJsXhgav8
 xG48GE5K2sT0yRp/yYhhf3suXdWGutVkhEOU+qBUPMIiIiS7Bcc/OlZlrBOTqxs0v9YhOB6+inL
 dEX7gQqCff0ZPyAGOEBye/7cg+enrAa8yPIHcseETxdybxELh6/Dm0HrbhalRmZO+PnA61t7aUI
 niQsRmrbnrFxNGufDonAKFXgfHw==
X-Received: by 2002:a17:90b:2d0b:b0:398:9be8:ea66 with SMTP id
 98e67ed59e1d1-39aee1b7937mr10712282a91.19.1788374483103; 
 Wed, 02 Sep 2026 11:41:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2d0b:b0:398:9be8:ea66 with SMTP id
 98e67ed59e1d1-39aee1b7937mr10712225a91.19.1788374482632; 
 Wed, 02 Sep 2026 11:41:22 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33255f2c1bcsm12059eec.20.2026.09.02.11.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:41:22 -0700 (PDT)
Date: Thu, 3 Sep 2026 00:11:12 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Sunyun Yang <syyang@lontium.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <aphtyJuQHQKRqv9l@hu-mdsor-hyd.qualcomm.com>
References: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
 <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
 <178766696083.117435.16339828039068931624.b4-review@b4>
 <apXKES8WQzVDbQG8@hu-mdsor-hyd.qualcomm.com>
 <DL3SHWGWGJRM.8EBXAKKNSVB5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DL3SHWGWGJRM.8EBXAKKNSVB5@bootlin.com>
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a986dd4 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=P-IC7800AAAA:8 a=I0NX2EReon8agFAEoCIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 83GFlQh-Xd9I_-Q1AQgPQf8m2ZAzgVd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE2NCBTYWx0ZWRfXwcY3TyePuk2W
 4GrvGC+TG9PHpxBEuMEuclajlkmGwBHPljQwZDa5KReA+vZqPW0RtnVf8Z1WtrLMpwW0vDSfti8
 H/6HGeAf52gShZCuUwgkcPDrjuY2JAmymkqKN9I2QRkv/4Q/93wje3o3Fj0RHIaveRPI+xl33b2
 VcdONfTsaLZ1q4kmcOU7gsO+ZhaGiTkKn+5sQfbowjT4QCaHXgOY5BYst0AWUFx/3A3Ds2kUKVu
 jsbCqKEdRpKtFK4WaOBbF3S6pio6q9C8UoT6fqY7FRpBFCYAr0zhv6z0UBYB0lSc2wdKIY/eIMO
 Vd1dRtj+67KaFDUaqdbhVytRIPljSTOcwUAO3fMC0RBcUltXMcVUo+hCoTij/vApoLfNOdq9xOe
 6Frcs4XaBoObmmi1ekPvZ1wpujJTva9bigQL1fHGUvDqTzoJmsZBgh7eQpg8NvaC6aiEPlzVeBC
 HpmdPzuB15ugh2QDuXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE2NCBTYWx0ZWRfX+VG8pXOSp+vP
 Q6gTLaSchdpFfNJ/cbhRDMVCbu7X7Lo3ROFoaQIFHZKjHyuNx/KuXhwEupPTRmBqSwoh8aNkjIY
 sYk7Pd0bcKWY5Dt5bJp6SdNMrJqj+lw=
X-Proofpoint-ORIG-GUID: 83GFlQh-Xd9I_-Q1AQgPQf8m2ZAzgVd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020164
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

On Tue, Sep 01, 2026 at 09:09:11AM +0200, Luca Ceresoli wrote:
> Hello Mohit,
> 
> On Mon Aug 31, 2026 at 8:38 PM CEST, Mohit Dsor wrote:
> 
> [...]
> 
> >> > +#include <drm/drm_of.h>
> >>
> >> Unused include?
> > Using this header for of_drm_get_bridge_by_endpoint
> 
> of_drm_get_bridge_by_endpoint() is declared in drm_bridge.h.
Thanks, will remove this header as well.
> 
> >> > +static enum drm_mode_status
> >> > +lt9611c_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> >>                      ^^^^
> >> Out of curiosity, what does "char" means here?
> > "char" = character — TMDS (Transition Minimized Differential Signaling) transmits data using 8b/10b encoding, where each
> >   encoded 10-bit symbol is called a "character". The TMDS character rate is the number of these symbols transmitted per second
> >   per lane, which equals the TMDS clock frequency.
> 
> Ah, OK, thanks for the explanation.
> 
> >> Also, I _think_ lt9611c_regulator_init() could just
> >> devm_regulator_bulk_get_enable() to do both things at once, but I'm not
> >> sure that would be compatible with PM. If it's safe it would simplify the
> >> code quite a lot, and also allow using devm_drm_bridge_add() below, making
> >> the remove function almost empty.
> > regulator_bulk_disable/enable are called in suspend/resume and in remove — so devm_regulator_bulk_get_enable is not suitable
> >   here
> 
> OK, I was not sure about that, thanks for checking.
> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
