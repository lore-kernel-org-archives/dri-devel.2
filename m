Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EB9C61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4146C10EAAA;
	Tue, 25 Aug 2026 14:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLkJTzBF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QXyUahxe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D17F010EAAA
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 14:39:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEUKt81050149
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 14:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=AKavK9vs+uNN8vu5dxdFd6iGSehyXJf1SG4
 Q5i0tYFE=; b=NLkJTzBFZT2ynw1HzGtHjpg0UXJW4nDR4apwpfh1lZINTmz/jc0
 /oZ2J5hqDA2ODs1oMHFCAlBGJSHDt76u+lHSIHFLc47FKGNLv9dgK1sFdfWCe41O
 p9oG54fDoNeIhCrTtpB5uXIZnr/PQ2WTmWeuWbyZQ/BKwBu/Kuyw4OhTQrfuPRAE
 KbxEpMDGdW23Rk2Ma/mRAvS53zMeJwhBgXmzLQNxq91vFuJlvhYEI/B3u+Autosh
 tVeODZkdoxNgFmHF7CHQo9qDiT4JAVjLws+hIO2RfzqxBqCB0H75VqjcIvl5a20p
 zjWigDwc7o+04kzW9iYKyRyG2DPiwAse1OA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93pvjccx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 14:39:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso69804521cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787668788; x=1788273588;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AKavK9vs+uNN8vu5dxdFd6iGSehyXJf1SG4Q5i0tYFE=;
 b=QXyUahxeckOCLZ3B0qeZUlzNforH65lYyAFdjUt1QH4/N39Ju015vjtOHRnENoT2pf
 BHodmgscg+jz9k/ffvLiOZ/XBIponymUtJUnMSzu8y4++Lk1Y4d/DyiNBwtR7h8fSFrM
 fXU6CiicV5YAgG6RF91LHyD4Nn9d/FF+khuoeYQ5fPPLv2nAKVv6RsinoMUo+cAHPGGW
 nG3+ZQvskNoVn4WUBpQaUkjJRqKfTTgz1fWAkCUktzi1D2/oa2cImP17BhKcXhSdIids
 WGnY509QMUwRdlbN4ctk2Fn5y7EYxrsyH9Op4hCZMAwZVnE7Pr/qp3ULCrplwKvX0CB4
 LM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787668788; x=1788273588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AKavK9vs+uNN8vu5dxdFd6iGSehyXJf1SG4Q5i0tYFE=;
 b=E1c08Y2E3XNk1SolDdW0lFLyUU8UdxneM4IuPmRh97sgNDFmAKTj5FHEWALYZKWYEa
 ljiyG4da04b8SkBzf4+Y6O+LkyFRVtPwhWTiIo+iiEgkvMtzHcj5c9+WBmmEb/0RCoj3
 EkyCDosq3tUzFsbmMurGc5paImqqV7gitDkSnRoNbblMhCiGKmvNLPS62xZ0f64lxg9G
 sNCZ3iVCa9yuYbkDYQnVUNVyA9CKY/5+2nRBCOok2mN4ZM8obgMB4biivU9Ww4GRjoRq
 1LGSQFWO2qRvYIkEM7fN0IUcjq2WxFo4Elghw3+JAQXDOmRbo5Mkh/UFPD0lPAQPTmUd
 YD5g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+X6GXFdtMcbLHFFXSSYfS9yTGsmONTvCIA2+rKfWyO+vkqaL3oQ9O5gZVvkE0bnCixGdv7Odgt48=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lf5/LiqJ1VQymWv9sjhPMWqRipBheImxmexuDGERfrwNtQJj4o
 assqdSZ0Uqb+z1PCKav6WmLWkUT1Ps5PmmvXC3DUy2yg+T+IhyHayjlELBPLFE3TA9I/U4FP5+r
 5B6u8f7qcagtQtGkbecL9I4ibu7EsjQ+C38xEz1+V+Ln9K/NRmmZAGo9eFjpiMV/hYt9bTDw=
X-Gm-Gg: AR+sD12xzLc0NNPOADBQnGzHkE0c78kRQifFlCo0oAHlvjQCvm7VwWkBzz2Ozo8o8Qh
 FwI/MM16Re5anNvYqZocu/4hOuBKx5DtuHWezBVi1KcLnj+MTW+okvXsfBeE+7zx21DiwdM94ri
 zTAJ2T+POcwp/sO3oXTpvx3WpK5V68pzcUnKcB1vKKt+66UWsZC5GPzKuU15Yc3oEWhYLiyG5LY
 5FcPXYA6vNRAoDT6CFm9cIxLVnEe0MTs2Oy+hU3Fht7NWC9VmAPjw6ok5Bq6/2bXxOw1VxQySH7
 sQ7Ty2vKkQV4+eqDGMrvWczpxudMwRnOyVAOGt7BfMSgrr6AO1gGtQEySnG/sIH4SnpNyNuktWB
 41Lim1WH0ow0Bxv4=
X-Received: by 2002:a05:622a:859c:b0:52e:1e8:220c with SMTP id
 d75a77b69052e-52e01e82465mr268241541cf.24.1787668786850; 
 Tue, 25 Aug 2026 07:39:46 -0700 (PDT)
X-Received: by 2002:a05:622a:859c:b0:52e:1e8:220c with SMTP id
 d75a77b69052e-52e01e82465mr268240811cf.24.1787668786309; 
 Tue, 25 Aug 2026 07:39:46 -0700 (PDT)
Received: from quoll ([178.197.219.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295632sm2053242666b.18.2026.08.25.07.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 07:39:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] drm/bridge: lontium: Drop redundant vendor prefix from I2C
 device name
Date: Tue, 25 Aug 2026 16:39:22 +0200
Message-ID: <20260825143921.512966-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2661;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=xVvLVTtAXy6tjWXIqT+vTFRuGxuCUA5BmEXNMPfufR0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqjakZHiQF9Dbw0dzltJE4tWK6wlI/jLTKJdkiu
 WiSbHzLuIGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCao2pGQAKCRDBN2bmhouD
 1+ysD/sFsLWqPGZAI7JrdejGzaI9a/QIK8qN35RB+dnEQLX8q2ytZMRuDHWvki65gWfIEFexl5c
 R62wtChaW3Z9TLgQGuu5upNZGW+zeKEUY+SHbzoqZTf8lI8Pit2HUKhey4GX7+Q0yzfoMZRyyOl
 ovynCc970NLeDQrOiPVyhkJH02eFYBj6fKkjoFuZcvqwxsMOH3JQf+EfVL+ts1b/lCwQoRbzJRf
 lSJekvwVn6RVUvIqIUZOgwE1CHotIvdBqdePiTqvFXGaUmIfO0YsvYrk59GJcg97Frzc9nEGH8h
 6GhTYXlp0jBYvdcWdgj/StIm8Tjtp6nV6Xyldo2M30ORB9jX9o8iXOxSPy+SUwLFRw7TkxGfpLz
 dttmoEczSq6SkDZp1BOD8vzKQwWZO43+9hzrir8KUABbPx63z+kHaPaBa9PPzWATEyA+sgNEw0N
 aZ/hiGE7yD0E2+JA/4GYj87cPAF9Phh9mZ1tycfLbYrAT1o/p2Tnxl3lrfOVi8Cla1IVc7J7ydb
 S6uKo7YEPyYZDF7szBb8kMOjwXq1EgUm6gi2bWEK0owk9ZDeZ8zmtWefaNw/p3CHcimKwE11RCC
 JD6Em644ss6sxNOiMGY6UpSijIwhBHuzXwR6hbIQIKJQcaf18+u9xeZD5ngFMD8ldsjDDUQNrOS
 Mm5oyZnkN5JBC5Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyNCBTYWx0ZWRfX6FRacTmKBjrp
 V7Am9lD8cLOJ65+cyubiwUfcI4TpXmojmfT9hzLBM6DIeRWlGr9h0o60IT5fEHWirC6t7RBdCjC
 88FsxhMxs9XW5iNjXHjGFnmtqTLK9VU=
X-Proofpoint-GUID: Vq4tyBDpXWTfToLoxcetBE2WSMUrHVh9
X-Proofpoint-ORIG-GUID: Vq4tyBDpXWTfToLoxcetBE2WSMUrHVh9
X-Authority-Analysis: v=2.4 cv=Ru716imK c=1 sm=1 tr=0 ts=6a8da934 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=1gE4ys3HJQNxJaVJTSIA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyNCBTYWx0ZWRfXzm/UBM9jWL9P
 KlNxY0kLuxpL7zBOT8aNyGsKW0AYPJFt5RACRvZvFyAQhzjV0Fyx8IetEH44HwZsi8B0twXXvUI
 yzIJBckWMBgsH8T943CtO34qL+tvmaiSr/5rZM0Csy7lr+BpyznCx+39ejEAH3/1ecaUldGQTen
 9Tq6NVfWYLP9hIyrvM4MZwPLQ0qm63IsIWf7iseaE+aVxD3tE/VFl8kRcRFMCgJ/JwIw7v0UvqB
 LWsc80xHJ1xmyxxSUBrlyW6U7+uyewglERRuL3vPcbwa2tQlsriAsl0dcfcS2Sf9LqtH2DArK/X
 ov4DnzeRqidUl969S9ku9AYaZWKNP5M+ITaxKAWsMSa4aS22/AY63hwnJRLD1bHhV4rUoc5MeJ6
 xEduQKZ4Qat+yDIe2BHKd/6NY5bexqi58px4Qu9nMCIgSxAeEnLrjl0ulZoo4/KIt+z5u5CFtcj
 l4ltniS7ceeFrBQHevQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250124
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

Device names for i2c_device_id are not OF compatibles and have a meaning
only for in-tree users (which there are no except the driver itself),
thus vendor prefix in this name is completely redundant.

It is actually a discouraged pattern because for OF platforms it allows
matching driver by I2C bus, instead of OF, thus hiding incomplete
way of obtaining driver match data (lack of i2c_get_match_data() usage).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt8713sx.c  | 2 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c    | 2 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c    | 2 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8713sx.c b/drivers/gpu/drm/bridge/lontium-lt8713sx.c
index bfff28883280..926f9e1e85bf 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8713sx.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8713sx.c
@@ -572,7 +572,7 @@ static void lt8713sx_remove(struct i2c_client *client)
 }
 
 static struct i2c_device_id lt8713sx_id[] = {
-	{ .name = "lontium,lt8713sx" },
+	{ .name = "lt8713sx" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 23682384daf4..285cda58f661 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -773,7 +773,7 @@ static void lt9211_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lt9211_id[] = {
-	{ .name = "lontium,lt9211" },
+	{ .name = "lt9211" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lt9211_id);
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index fb34f661ee0a..cf3a653d40ca 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1229,7 +1229,7 @@ static void lt9611_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lt9611_id[] = {
-	{ .name = "lontium,lt9611" },
+	{ .name = "lt9611" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lt9611_id);
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 42a6503cd0f9..b3bb7f2cebb3 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -899,7 +899,7 @@ static void lt9611uxc_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lt9611uxc_id[] = {
-	{ .name = "lontium,lt9611uxc" },
+	{ .name = "lt9611uxc" },
 	{ /* sentinel */ }
 };
 
-- 
2.53.0

