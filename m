Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1273606A322
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TxMJRzQF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hGivdKjh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43D1112B5D;
	Fri, 23 Oct 2026 13:40:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A34112B05
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAULs1948370
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OZyxso0AaOeFf5p2y8usJ5
 /jhDO/hkU7VHpqvGOj+GY=; b=TxMJRzQFENnrmyB7Yhrx6phI9seAwH/ZWkk/zL
 m3JhXHMBTBuHKWQCFqQ1XwuYZPl/aa8Y+DUfshW5F/4x6zs81QYipC47HPnOnLro
 +k1/Usl1eM7AqiOajLBIzdK6PL1yEOg/TAcxkJd/CW/+Ub4zmjwdi1ILDInOtAfy
 OZ4e5aN/sDqO2nBuwNNQaHXFUfteZa+gentyUGltaWOQ72I2KFYQyrgfWxk+JiSI
 QVNhMYXo73yJJfX5wxQL8Hro7y8/algrrlMcC+18zijhH+Rl5djaRYzvLGX52Ct0
 bDjrYmKbjPE6QyfFNym9APk/WWS6M1jns74rWqd00WDqWJIw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtuwu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:40:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179a2035a4so42536986d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792762804; x=1793367604;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OZyxso0AaOeFf5p2y8usJ5/jhDO/hkU7VHpqvGOj+GY=;
 b=hGivdKjhZe/TXL0OCbu68WFlvmSJ2Jggm0oalMHVm40X9W1tVWrotaupWQ6QKuo7GN
 2zZyCxu9C4Md8KOi4id4ckHJTA9dznCx3Mcncesj3u3GETAtRaJVaqNTyKQQL6IBvGAs
 plLVKhl5ciQ85ONs4sAbgG6iOokv9DR9iwGFVQkXGlOPvFGNbc81e4ULCMJ/LO2R+etM
 sPfir4P/vquz+5oMUWqHHi/4pZwvEY1BRz9Y961hOXDNabMMwIJAr68RQ/ep8cpLd28e
 dRh/SQKKudgTEk3DmQjwbtBlYYlU9V3ZZaoYhyjrS+/DvglkxXnVd0uuzjED5VnFHTqE
 OZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762804; x=1793367604;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OZyxso0AaOeFf5p2y8usJ5/jhDO/hkU7VHpqvGOj+GY=;
 b=Ds54Q0cTyHle8yMd3NqugyovEClo0KqbO3cDMkj/74hHBNqxBcWs8Fjv+1Dox0zRKL
 xRN5NAKR7LGX98wPnPF3LaeY95k9GtsbY9ZUvPOI4L/pCnS7zWFveup57TvnIJjVDpo2
 jnhkCIO7TQwp545kM2Kx2sEuwHVJfcW5SX1rUrqUdaSdDtBnnGhsDd8jo+qOxEtCO7hT
 fvIJkDcH+ieqbYRuSwsZL4ZqVAu21jAXaqkB4h1ZCktzKajeAPkOBFiu5Qa3LeJGEfRK
 dAhwr2W1PNQVdf3Q1LDvjH89knLtMwcb9w9eSQdJnvxjAV0uprS/2T3cJwEN1jWBSPTc
 X/2g==
X-Gm-Message-State: AFq9FYIkmBOk2Vhv9a3bM1nNmyZl3pRp7YFho+74BBlbty8mP8UVRcwO
 b2gfqJcAGCMZIOZyTYZy9xSbBvrLMQCsIqJTq5GfEq2au9TKLCgbOy7Fw+LUqEAa274Ip5IO2eu
 oADScgdlEHuewFLQRHCvykBftezUPgKK2w8jjp8Cv+nzLI/I+qGWQaCDGfLO7LWpnRTnEJB8=
X-Gm-Gg: AYBFou26NlDCeUDJEz9SuOv90U/D2MEBZLOYgD5cPL75NoeYhG1BFNuDzkWAo0tlBOd
 xbYu2WDIVGy4fUCJXwMTGJ42TdapJ9rk8oJcmp7KGNqtL+FX+vvgo+OCe3JK9B0l/ZU+4w3jaHh
 LP8HsK8uaa3X8p1aCfYqYIA7imsHqh1Fo81prkeR22XETGjcmiMMZ3jQ4slLJ8Ck5UQ6abTdz8W
 w49+aStqaM8pY4WA49QNYkOKcKR+/z0HcfCyuFQPFR+X6Ix0R3E5IeCFiDrF4QXFBDK84ORzF7P
 n9ZctoQTSDNdL8uchI3isHrHTsPkT+8gB4QwwSbKtFxC87GnIenniW99tKgx+8abFBGvjRfhN2v
 HaSDZbojqqtqzKO8sDx7MSlKWc9+i6cD+zAqEW+7VB1eUUafpIJtSI8viOrcQb/CQO2LbnM29Gb
 3g5oUdKGrhcJcN
X-Received: by 2002:a05:620a:25c7:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-93f6235c83dmr860055885a.0.1792762803631; 
 Fri, 23 Oct 2026 06:40:03 -0700 (PDT)
X-Received: by 2002:a05:620a:25c7:b0:93c:3863:ff7f with SMTP id
 af79cd13be357-93f6235c83dmr860049585a.0.1792762803079; 
 Fri, 23 Oct 2026 06:40:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac65ce14fcsm5309701fa.7.2026.10.23.06.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:40:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v7 0/9] drm: handle IRQ_HPD events correctly
Date: Fri, 23 Oct 2026 16:39:40 +0300
Message-Id: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxj22oC/3XPTU7DMBAF4KtUXuNqPHbspivugVj4Z0yMaNLGa
 QSqcnecImhFmo2lJ42/eXNhmfpEme03F9bTmHLq2hLM04b5xrZvxFMomSGgBiUUb46Bp/7EaaR
 2yJwMOg9G2yoKVj4de4rp8wq+vP7kfHbv5IdZmSealIeu/7puHMU894vr//goOHBhnYjCR4cOn
 7uct6ez/fDd4bAtD5t3jHinICwULIoCjJHQUE31iiLvFbFQ5KyogC4qCNGvdVE3RcNuoaiiSHA
 anZSV2pkVpbop9YOLqqLEKAIB1ODNWhf9pwhAXCh67iINWRmCtfqRMk3TN7jY0hAjAgAA
X-Change-ID: 20260414-hpd-irq-events-e72bc076a5f1
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Francesco Dolcini <francesco@dolcini.it>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6276;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=niEm2MZMIIMV2XZngvo1nnwS1Exvi2T37RRlW6xT5ZE=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9bt5AU+fHH6Z+aKiHw/fPhrrVuZv3Nrj73RuuoW2e8Hl
 i6cz/ipk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQAT+feDg6HjmNvhRUqsHt/l
 YgTX7Pd8kHr2/UfNWSnBPi1qa2OjlYVu57+3u180Mb3raryN7eM0nxMN1zuPHhHbpZax+l4+n4F
 i5MSo92+XH9ve452iUqPdm704Ryz+ds6dPfNUgqRkqiM9eiQT4u517zfeolTyoPAW64p79d8UDI
 LEPKqTOmKefptmHvFLyie6rvgxY9CNK8yh6032erD9u9P10dZB0sGH20eELXt5Y6/xu7dML7ytf
 GdO1D4lqOtvLijIXdCd9X5B7fkDPZGbl+6b39D7/H5+VoGG16N9vHnHuoSSJxyUt7EIiUmau7H7
 yONXt2dEeIhIT16V+r2u4l1Lw5OpLk+nXH4lOLs/9K4BAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb63b4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=ag1SF4gXAAAA:8 a=KKAkSRfTAAAA:8 a=P1BnusSwAAAA:8 a=P-IC7800AAAA:8
 a=GFqr32JmAAAA:8 a=IpJZQVW2AAAA:8 a=mK_AVkanAAAA:8 a=tVI0ZWmoAAAA:8
 a=s8YR1HE3AAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=uf6nnPeBmoxfmv3DkCAA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=cvBusfyB2V15izCimMoJ:22 a=D0XLA9XvdZm18NrgonBM:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=f02Ha7HRcztGgdyUxOxW:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=3gWm3jAn84ENXaBijsEo:22 a=-BPWgnxRz2uhmvdm1NTO:22 a=jGH_LyMDp9YhSvY-UuyI:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: ui8rRN-O9rZuODs2xg-pDwjzSU9qrkju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX2WEDSBUXoNNu
 ZsGbQw/INqJvp3o2N6HgSGCZApbu5dT59KGEY4aSSN4hHy+hI7H9J8HNSOLAEQv5LOuDsaai+su
 5mAIXNW0IWUV03jEkBzEyz4XjZX6z4Z/cxPDIfZHsQTZeQVUqnW3XdjloGFUmp7sX/dy6fej7v6
 rddL0yE4LjnVn4nMb9k266CLiV0eclbkcqzcXCqk6VqOcaMXN3VMR++iuZnlF1JhDzDJTRZf8gb
 pT+HB59W/sPMK03cGgKylwOFmeMM5X90jO6Wo0jz37Q5eB+e/FImSTZyeslAGFeJYL7QHsF/MgA
 Cw9fDcDyeH+gAuURp43eAUzz7gNOjNGVApKSeD14sqRF8Af91zvC0sYzavYgCmdMKHrIix7BQpn
 PytGwB0aYEeygd/TAIScbDw2Dc7yuF3OpZSCI7+yHae5Pz/tVe1sHC7F0Vp617Xs3s8mrLQynAl
 ExCoUCJhc6KuVa9XpLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MyBTYWx0ZWRfX7eM1R20yM2a9
 FAzv9Q+YPndOhSrirx0lUTphv4pyLqKfoGX8/VZtGXEBlsoPQFsujYkELtQCyyLZqFTERL8WdPp
 f4QwhilP9MKjMW1+innxfzDm/yORpe0=
X-Proofpoint-ORIG-GUID: ui8rRN-O9rZuODs2xg-pDwjzSU9qrkju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230053
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Both DisplayPort and HDMI standards define a way for the Sink / display
to notify the Source / host about some kinds of events. In case of HDMI
it's as simple as singnalling changes to the EDID. In case of
DisplayPort it's more complicated and requires actual checking of the
DPCD registers.

Currently USB-C drivers don't have a way to deliver the IRQ_HPD
notifications, leading to missing MST notifications. Provide necessary
plumbing to let IRQ_HPD events be passed to the DisplayPort drivers.

Note: the Yoga C630 UCSI driver and Acer Aspire1 EC driver are not yet
enabled to send the IRQ_HPD events. Both of them would need some more
reverse engineering to find out how the event is being reported by the
EC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v7:
- Fix build error in drm/msm/dp, forgot to squash a patch
- Link to v6: https://patch.msgid.link/20261022-hpd-irq-events-v6-0-337ea3ddaa62@oss.qualcomm.com

Changes in v6:
- Corrected indentation of args after the function rename (Chaoyi Chen)
- Reordered / rehashed patches to be more logical (Chaoyi Chen)
- Fixed build error in the OMAPDSS HDMI driver (Sashiko)
- Fixed IRQ_HPD vs PLUG interaction in drm/msm/dp (Sashiko)
- Link to v5: https://patch.msgid.link/20260920-hpd-irq-events-v5-0-ff1de0090c72@oss.qualcomm.com

Changes in v5:
- Renamed drm_connector_status_extra to drm_connector_dp_event (Maxime)
- Link to v4: https://patch.msgid.link/20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com

Changes in v4:
- Renamed drm_connector_oob_hotplug_event() to
  drm_connector_dp_oob_status() (Maxime)
- Reworked commit messages, explaining what it is about (Bjorn)
- Rearranged commits, making them a bit more logical.
- Link to v3: https://patch.msgid.link/20260421-hpd-irq-events-v3-0-44d2bf40dfc2@oss.qualcomm.com

Changes in v3:
- Fixed build error if aux bridges are disabled (Intel GFX CI)
- Link to v2: https://patch.msgid.link/20260420-hpd-irq-events-v2-0-402ffe27e9e9@oss.qualcomm.com

Changes in v2:
- Change irq_hpd arg to be an enum, possibly desribing other uses (Toni)
- Account for that, chaning the API accordingly (with_irq -> extra,
  etc.)
- Wire up AUX bridge notifications
- Link to v1: https://patch.msgid.link/20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
To: Francesco Dolcini <francesco@dolcini.it>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org

---
Dmitry Baryshkov (9):
      drm/connector: report out-of-band IRQ_HPD events
      drm/connector: pass down IRQ_HPD to the drivers
      drm/bridge: pass down IRQ_HPD to the drivers
      drm/bridge: pass extra events to the HPD callback
      drm/bridge: aux-hpd: let drivers pass IRQ_HPD events
      drm/msm/dp: don't take extra references on multiple plug events
      drm/msm/dp: handle the IRQ_HPD events reported by USB-C
      soc: qcom: pmic-glink-altmode: pass down HPD_IRQ events
      usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ events

 drivers/gpu/drm/bridge/aux-hpd-bridge.c        | 11 +++++----
 drivers/gpu/drm/bridge/chrontel-ch7033.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt8912b.c       |  3 ++-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
 drivers/gpu/drm/bridge/ti-tfp410.c             |  3 ++-
 drivers/gpu/drm/display/drm_bridge_connector.c | 22 ++++++++++--------
 drivers/gpu/drm/drm_bridge.c                   | 20 ++++++++++-------
 drivers/gpu/drm/drm_connector.c                | 22 ++++++++++--------
 drivers/gpu/drm/i915/display/intel_dp.c        |  3 ++-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c            | 12 +++++++---
 drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c            |  3 ++-
 drivers/soc/qcom/pmic_glink_altmode.c          |  6 ++++-
 drivers/usb/typec/altmodes/displayport.c       | 25 +++++++++++++--------
 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c    | 11 +++++----
 include/drm/bridge/aux-bridge.h                | 13 +++++++++--
 include/drm/drm_bridge.h                       | 31 +++++++++++++++++++++-----
 include/drm/drm_connector.h                    | 24 +++++++++++++++++---
 20 files changed, 158 insertions(+), 66 deletions(-)
---
base-commit: 725953d4da85cfb97a4c309fad6346b72f8529e7
change-id: 20260414-hpd-irq-events-e72bc076a5f1

Best regards,
--  
With best wishes
Dmitry

