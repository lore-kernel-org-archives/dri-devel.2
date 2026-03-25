Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8469103A999
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:31:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E37B10E68F;
	Wed, 25 Mar 2026 02:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j0IojCGh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+oo4cnF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C9E10E68F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJDjll3984442
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I3FthL8fdaNiAq8w63ULdQl0j0nGYrvDZqk6timWV2Q=; b=j0IojCGhAWZqLdqy
 ThTGZk5sPisvcWkmVl2wZZtNg9kGSMNhLuoHW0PbtzQZTGYHQSWAfR/oKQpYWDQc
 2nn+hTDuBDsyzmvbQBjiTtj2w2kdo2HTo0v4NuW7xuvTiuzwAZ9XrH8IRZBtODF6
 Spkunc6tdJA0YdcGMF12Nu2ZTfh2X/65nvfsM0DXI3zMnq1fmTGE0PMgE7qvYgZW
 IZV2ioBiEE/J9mGJ5TPLxWuaZ375BE/mtePVu671mbdqobu6u7RUvJfvV4+Wkbir
 HXz9OSBJDwvOfDl5lEYGznkuoVP9pIq8D6sUs4W6pApOmN1EL3XJBzR0VP/e0kYm
 deJb8Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p833vyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:31:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50911c94db1so90371691cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774405866; x=1775010666;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3FthL8fdaNiAq8w63ULdQl0j0nGYrvDZqk6timWV2Q=;
 b=j+oo4cnFvEZi0rsPrj2XASJ1d9s6USW+osl6jP35DBtgWNWCun4qTFFCdG2iDEdtQh
 ZL6wTiD17QogJvxkcNjI4x+QqxfzU9F1sdE3BizphpMNAXyhF6AHFNEP9lNaF1qO8rwY
 hWEH+R1i2L5ivFor1OicLxqKT5sMlvDgikN9LhLUJ3eFnBH6q2yvvnIiUShaKbeH1TzF
 3DgAItvTNhUMElgHXITv8JZg5JC2UGzQ6v03GDe+LggxhBPF/HIcuVurth/f/JkBQtvn
 k6u/UU9a+7eks6hpu7fzRUvLgivR2c+FcWEekyHQAzLwnodcpDRx46LX3QlqOgDBM1C8
 ZJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405866; x=1775010666;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3FthL8fdaNiAq8w63ULdQl0j0nGYrvDZqk6timWV2Q=;
 b=g9VRSNY0r62ApVYssb4FAj8zvj8w69U1Dsb3DYB0Ph11KzlVgoQswqwoasc6BSbwGN
 lZIQ72L43M2J6C2ambAGhTsPYceBPe3BR0y0zI0AMbGWqyMwQPv2JFykYuJhof36Oqja
 AsWjpbd3crvpTbN/3oNPg+56uNS1q2ZOLSvbtPFWSzSSmKdpFqbIWHKdgQUnSlaw6GZK
 yTIu7DMCjz1L/Z08KJk1rrOo8LubhZXNbhsJ6T0i1yltJSfKyejjFNxEVZRjhj62vAhj
 /oLnwuHWS4WTjlZIi7LAX4gP5nJw5hKxvQVR3eRRFhKaJzoOqAxcRBN2M35PQuDSj7OD
 oIKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQhlFgc5ro6c6W8i61reAOibOcwD21SItYsgjUgPwVuijIZEQQZffpcN55DZFGCOvnnYNa5q+177c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaDgkOwmobtExS1uVErIeMWXwwP5XDnfe9IewvBryuHmKF/WbT
 ov4xBuDKV8Ox6qsrUUwSlxFL1/q+G+GA4nH731MrgFyVwzJQ5HgY9D6d0R3/FSyrqs7MczmDCGc
 W9Gu4N9aci7RLZILa4+wtcYFge1Lp7aKEErHDRCXssz9oduw3CuWxV7k+3ic2Lmlw9LdUajk=
X-Gm-Gg: ATEYQzwVHhdzbp6X490NT08l/bYofdg9HZSmg50uSHI696CROc12w4tZIO19WpYwq+d
 x8OfwyLDhlMEgYfAYDZqqy/igA279Z3ahhIf4BatkgQFNliwgVUsI3dmaC2PZC5/M5y4kKeJTEP
 P3ky6oCYxEaDx4jafM7CrrOn9OOvxgFyeS2sTdx5vfTX3Ymoes1v8LBIe2PPo61QH5CUS7vGezu
 nvTQHgSV9O0IJ0jvhRXLDxwx1Op6r8x4odrZAdAhGtsgG9EIkNa37Hdyxiw3rThEyp72GIf/YXD
 zUl3iltvEaeta6wtw6DdS23YTggvJ6J+JJmlgSUqKCU7mFkAMQvPjT49oGJZnQtsNtUONnuZB4N
 wkRqO/wWiK91WAlUqBg1gFVdw/bvND0T/oQc11oofe2tj5sroNT1C0bFe1exN/Rvd6AVgQ3vkdp
 b460DTwSS4RKZBT1tkNH1c6JNw8QeEJYojiAc=
X-Received: by 2002:a05:622a:98b:b0:50b:86f5:8fbb with SMTP id
 d75a77b69052e-50b86f5917emr4350541cf.38.1774405865642; 
 Tue, 24 Mar 2026 19:31:05 -0700 (PDT)
X-Received: by 2002:a05:622a:98b:b0:50b:86f5:8fbb with SMTP id
 d75a77b69052e-50b86f5917emr4350261cf.38.1774405865246; 
 Tue, 24 Mar 2026 19:31:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f68sm3412014e87.52.2026.03.24.19.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:31:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Prahlad Valluru <vvalluru@qti.qualcomm.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Eric Biggers <ebiggers@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260318105130.1969966-1-arnd@kernel.org>
References: <20260318105130.1969966-1-arnd@kernel.org>
Subject: Re: [PATCH] drm/bridge: lt8713sx select CONFIG_CRC8
Message-Id: <177440586380.1663773.5578765905624833617.b4-ty@b4>
Date: Wed, 25 Mar 2026 04:31:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNyBTYWx0ZWRfX27gasR0J5C6T
 yoSeAseHlzf+NyOmvJqELmiNBZdwkE/TfZZc7tzZ6g153lIBCD/fedoqLwn+OeBMHSY1FnZFM1U
 mdexmo+tv2OTTk1Gn1qDcAb8FI+syP2QxOBIKpSygkflWQuHHkXPy7MNM6LnI/Rb5uiR0ID7IES
 WU3Ovi71lB9vsDkxWFddxl3AWoAiwXvGIDnJ6JEJmr1esg7Sa5+VHGZU9rk7l12ZnLughA/WZoW
 HxqyR8Gjc4TpkGXRU3FrzAhNYC2AV8pXbCfPr30sUjLTGlgdwTuO7zTkgPAKCO4XCFxghPz7yZK
 WR2WZSWvVC2hdHrl7WNIhb5S1TTXk4zz/yesWkm/jX1CNKRZR8w3DsltRPYeY4vM78quxME7BP7
 T5WZR0LkuHaX1VphSzRds2Yd8z6S9iTzRMx9PkmGJPm4G4RWjNTlxR+Uzb0/KJVDHMyMVL9tnSL
 Udw+oKTNQhO1aZiXaFg==
X-Proofpoint-ORIG-GUID: gHKDgnaaTInfMHKKkZx-a5QhDB6Bpeyu
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c348ea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=ekqSGKlHTfsKJbvwCw4A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: gHKDgnaaTInfMHKKkZx-a5QhDB6Bpeyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250017
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

On Wed, 18 Mar 2026 11:51:15 +0100, Arnd Bergmann wrote:
> CRC8 needs to be enabled for lt8713sx to build:
> 
> ld.lld-22: error: undefined symbol: crc8_populate_msb
> >>> referenced by lontium-lt8713sx.c
> >>>               drivers/gpu/drm/bridge/lontium-lt8713sx.o:(lt8713sx_probe) in archive vmlinux.a
> 
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/bridge: lt8713sx select CONFIG_CRC8
      commit: 9a9d5ceff9581c92e4758f736dc8e96c22fe643d

Best regards,
-- 
With best wishes
Dmitry


