Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B90CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 12:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E264C10F46E;
	Fri,  8 May 2026 12:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XaJ3ctv8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F8SDuIHq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1958D10F46E
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 12:13:10 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648CABXU1174043
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 12:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AzJKM4LY9eDR05imqaETs6SnpHADXv5BDM6HRtwJMwA=; b=XaJ3ctv8qvehTC7D
 GxP/NOyT6paq8IsQE+pk8dkQoaegmlN5mRIOt8r8WE4VRqJcBU/LBfoVdSmA9AYE
 /I6MwWtHP9l5VQ7yMRRhl4kscwSapmDlGqBukoC16PJXtHpZZzrBsMZfOvh9BhIu
 xT5KgH4vuFvGow9JqtHsIc41yURC0/P2SOL1fmIJdGF49hWyiyahxC1xvl0IZ+zY
 tHYxFh5qr1/yg6Xj8GWKInnbSS9q32ZmsyCtmY8aWu4VesrbGCLEx217f4JuPFNN
 JYBuYjfKlvhuxnsFh6vqPFiRBmdk4OJ3AKZ79UWJ49sV2qL713NviRazigps6ArU
 9U51BA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e132hathe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 12:13:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-611af0d600bso1262459137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778242388; x=1778847188;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AzJKM4LY9eDR05imqaETs6SnpHADXv5BDM6HRtwJMwA=;
 b=F8SDuIHqTunzTIBRf9zaX8A1AmGDSr4fUv76Wz2l4yGH3Lc6uEXfNW+sIhyAKvpBEJ
 4O7cGZc7/0g2gpbnMKoAe42FGP7WuaOkIKgcrAs+sNo1WSmLj9MXj4UDKZpKWQAgIihV
 rQ1Tzbd7padrzHdK+RYWUPjJJd0/2YkrCnq+2AZZfOLTMvhk08yM8sgTBXogH1tVW6Sz
 C4Wjj+Zq4EkhzSu9Xi4RJ8K9CCl+ICyjHAnTK2mZbVlxfj7bUzLEZX8EASo1/CjGaI5Y
 AKLuFssB9YmhB9+GBFkDqR3FoInVjsU3PI1bxVzzAuR1yo8MK9382UTOQVj98XMt7ixu
 EPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778242388; x=1778847188;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AzJKM4LY9eDR05imqaETs6SnpHADXv5BDM6HRtwJMwA=;
 b=NouFrOCFFNI0vw8sT2Qe7Pn9RRI0p8yGuaii/vuwB05zJ9Uv5Kgy+tjkoPR3xexehF
 sfUq+8B63mwXdVEljD36uHXy3Y3mSXBXjmsk0dIvCOHESSWQp70v7Ixk48AjfZA2zWYm
 84RvgfWPsTBf5tuVvFERMf9E8EJWg+o/eW+0wdp7c+0kpEkjJcWYo4Pci466SmCs09fK
 JMNiMOAUsZUQh2CqqUkSYb5CzpfiYgkPNEqW8cC+Jnvp3UOFGxHm0WDbLggcfOYbwiBD
 UfKCdKQ9tKvelwhM+UqugADT6ZkTZ4mmADr72/9HUYvNahuA4vcThhCCbFmZn0mRB5z8
 WE2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1C9b0oEZ6eE5ytaBToABHGlS99zyIsUuTbrp6Vzfr/4+1lYs61VTvg2ZxI6Hd4p/3L/eW5GUjhEw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yws4rTXiCv6EZurKONZSPECIuGab4DI1leSyEOfHrztQfxGzGP4
 cEX5o44t1as5FxdODe8azv6JCdpdUODo4ai5BSxZlJyAz/nGZnHOoaPvZIEZfflHhzgkZtAfug7
 XGP0clkB8V3xSdKTncdRwkYg4nlevgWjE2PLtJDA9MuyEVU0w7eRzJiZf+DzaHgELejezdyI=
X-Gm-Gg: Acq92OEpJwz40o/3jJC1fsS/GlkWslKP/MHYFWmbj6imodBtR8hItMjLWI65ItsmTLP
 peJXkVjypf8Oylnl0n0xjmGknTPCJXAJrup5GlY3+pZWOz23uQXwwoOszWngZBj6Cwrp2RiilgX
 CYn34L6QXBHZC6dMuhgc+Kh6PTkxxB2FW89vyYE1FXIYYdjiF7Y/NZ39iWHlZkHBkm0xgQSayvC
 5pLkSDGzw8wgfBxx73WPguTAjxZz+CYO9A47CggsYRcJZBHS16NlLei4L/Pb/36rTiYf1/wmK97
 xTHq20BYeuNT7SDZQcKoexDAV61M1codyzDDpX0+Fb5Sb7oalDZtD3wVyBlAcqWCHkfAlP/Fq5+
 d+qyRjTdLRD+IKzwRLyMjJUzD1Mcz8qhbJG+jgbXbizCTLbAf8+1wVQm7d00vTuL5efyJJUbZix
 tNUZNVZz70Z7FyGkO42rbP+k+zI3tX8HgZO2A=
X-Received: by 2002:a05:6102:f9d:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-6314cd8bb9fmr251681137.13.1778242388320; 
 Fri, 08 May 2026 05:13:08 -0700 (PDT)
X-Received: by 2002:a05:6102:f9d:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-6314cd8bb9fmr251631137.13.1778242387830; 
 Fri, 08 May 2026 05:13:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a956b3d0sm455378e87.80.2026.05.08.05.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 05:13:06 -0700 (PDT)
Date: Fri, 8 May 2026 15:13:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, yangsunyun1993@gmail.com,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com,
 rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v5 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
Message-ID: <ly35dnwogvo4omdjvm2sqajwponibhegdws6pdbthqf6zutscb@nm5j7uyfw36l>
References: <20260507024214.97708-1-syyang@lontium.com>
 <20260507024214.97708-2-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507024214.97708-2-syyang@lontium.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNyBTYWx0ZWRfXy1zCB3PYWGSe
 EHJejOvrQnok3bPgKf8Gd8HEy8hMt1rCeTjdydDMGRlMB+vENZTgwe0Xu5OAsbw3b5IxdG3aVzb
 YEge7DXg9XTGMvwASCd8Ex3sjEfLGc3cmxcplx2x0+WeaNsEJ9/zq2eb5JMAIeQtuE/cFHp4G8E
 YUFv3oKvK1kkw8aUux1OmsgKRpgrCO+AtcZ514cn0ZSwA1O+jGQCn9d9E9JbVn5N6LMfUmuk+qh
 nU5qOtle7dN36dPsQZa4ws9GLHiKu+yRnljOtV/0xkJR+2UHxChmaQDlF5OZViRixqg0QI/mszU
 DbMiseA6DmgquR4BolgiOvPTR0UgzPEcTfsKXP/3PqBtK7RnO7c1iXeFnxYs3f19KCSAj9mcoZZ
 qZEcQ4J4S9K7HcIoLZ53gw8+PSlBUPHmtsTupbeI40p2G7F2lT9bsGqV1hMDRy1rMyAZdoLs/xj
 0bexcE+spX07NzCsFfw==
X-Proofpoint-ORIG-GUID: Hv4lrGwFF0idTadCsrGCqzSB-ljCi98e
X-Proofpoint-GUID: Hv4lrGwFF0idTadCsrGCqzSB-ljCi98e
X-Authority-Analysis: v=2.4 cv=McxcfZ/f c=1 sm=1 tr=0 ts=69fdd355 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=gEfo2CItAAAA:8
 a=Kz8-B0t5AAAA:8 a=VwQbUJbxAAAA:8 a=FA6Kg9t7gy3gg5_aXx8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

On Thu, May 07, 2026 at 10:42:13AM +0800, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  .../bindings/display/bridge/lontium,lt9611.yaml           | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> index 429a06057ae8..b20a43456b01 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> @@ -4,19 +4,23 @@
>  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
>  
>  maintainers:
>    - Vinod Koul <vkoul@kernel.org>
>  
>  description: |
> -  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
> +  The LT9611、LT9611UXC、LT9611C、LT9611EX and LT9611UXD
> +  are bridge devices which convert DSI to HDMI
>  
>  properties:
>    compatible:
>      enum:
>        - lontium,lt9611
>        - lontium,lt9611uxc
> +      - lontium,lt9611c
> +      - lontium,lt9611ex
> +      - lontium,lt9611uxd

Please keep the list sorted

>  
>    reg:
>      maxItems: 1
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
