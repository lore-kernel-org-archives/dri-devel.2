Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6032810FC463
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 00:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8467310E21D;
	Thu,  9 Apr 2026 00:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0SCwCZX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hA6a50Te";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1619910E21D
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 00:33:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638KwMVb4107662
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 00:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VPebicgWeW163zCIOfHExmD6azJCLCKyS+x3r/GXDMs=; b=U0SCwCZX3X+QreX9
 INbBys5rUwg4oR4+lxiJ0/igdZze1ifAZ31n4ckjOaqtp4PddKYI0NqBsoo6Slzr
 BLu+rfuircUxWKya33zjFb4xxCJYdat8hZ/pEDp4LlW/tzPR5CBo+pYnNu9hpkEZ
 Jp+3dUcS4gepNuPz11Sui0I/9Dg6mBmxLUa+1r9KixFd43258J3AcbKqC/3Pj01y
 xJk7eZdDCFnqA7IarC4Og7y6T0oSh7fgkqRTjz0GeTFp80sV4hUHuW8bqOXDi9tZ
 RjasNPCPjBWJIanc0RLrlq1mRPczMnUaZ7WL32It23eqLUzfp3NNusw5NUaK1omr
 Yp6mpA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddxhagj1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 00:33:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4b81c632so12990511cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 17:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775694791; x=1776299591;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VPebicgWeW163zCIOfHExmD6azJCLCKyS+x3r/GXDMs=;
 b=hA6a50Te6+jT80kCqYIsj9jjBMQ7QznPgD0Hd2nzhWrAdz7L3rVGzyrdua1TWqAwd0
 Evj5b/iAonGqYauiaON1eR/0daeeITJBkXuvsdtBWp2p509MBZxE2hSw8Fb4RORnOqrH
 7dGN5tBFBegClmLX5slXXbXOBVScdvecJ4pbt7qraP9U6oBi/qyrMeqS7/vvddWmsUim
 wD3P2OqvfAff91wevn6rFF5f43XN6JgOfE8uW4yWVPJZQclRmZYiU7ygXDJmXCXtciPV
 lEXiBskRnj2K+9jahoz/HDQ1c9fov8kwyMD174GR0932aqQVPebJSWMgEGCqcFY8g3Yb
 yRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775694791; x=1776299591;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VPebicgWeW163zCIOfHExmD6azJCLCKyS+x3r/GXDMs=;
 b=kWZFUJb59VczbieCfD40Mfpyc6NLfes0UH3+A39ng5ju3EHmbKEuyQ0ApxgbKAP53O
 b5d685preK0HBj1TF5XkrMeB5Aidi4qlNbKDeD8LNhVLtOyAquJRGOcBZmCC22rxqv9a
 33qT9agr9ven7/JaG6CFTWLeR7UaxwHW6Ez67oDrXR/ze5rDY9lxt/eBoaNWMOupnib1
 8IVYGI6LdzfZOrTlY5AbZSl3zhmVHb0h5a2wb+CR+hyLgi26oqjZ66lDEc1OaZEMuYBV
 L2tjYynXX7vEY+ezLlCqvoO1WGhpG0D0s/xj0JygOb0t90YDr1tF9tFRHx/8N6wK2xoU
 uwQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsrVAhAwnKojEa8msCueS9/JeoDQ8IKx9qGd6WWIk6lc0oJ+x7QfcGXPR/PRToCH69mCRYRnXCpKs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5lTtvBhOOgL8/odx9+I1GSCmP3ygH5CFnOEAaLfSXOj3p8+XQ
 h7iS+4Fm61G11xdH6uc0buTlSlQCIrGLeP4eDHwl1l7zLGokCKWJv0Kc3UWaF8bX4G/6ZNJ37cM
 FnrTGFc65BO83xZJCNI57Xu64JbCm9bZnNLsAJrnHnHXWtUljcsiSywPf+W80sEbgQ9CS8Hw=
X-Gm-Gg: AeBDietHwS2hxx/rd16pT4AGcVbCeJPSntxDZW6QFDSkSv/w2jhGgLVoDZv/BB1QsQE
 9BDPC5BoFsxfsekzLXJ1Q8qlYBn6puKz+FdXyXI9oQt7si/2qIBJicteEbwahhHbEdHwqkhdTM1
 Rj0agJrqUmKhY4WoJIJn1y69ztMQB8gLWWbJXpdiVFEjn54dmFP4SZFmzy6qZ1gLS3r2s7lDZ+d
 su/V/FE53Xd3wJpcqGNqCfN03GmZSDHLobVkGNYzMeHPkw55JTykpk9xmAbkAir1jZh2O0rX71o
 e4LQ0EJFjf0Lm6BbHzUBm3PjzWJS5bZH9CZementAlEFk6q9pfgzmf1/pnA/oVNmplKU+S4uFHj
 LsfMbatV2rroj4i+qhrvj4qRiJM5eoH7Zf7Bv+ZE/d7vARnBg5+788vIB1MRGbn/jRqNNgWNYwz
 TRxlQ/XM6y+ahpMP7Vk4D+BiVfgKbw8VWBQfs=
X-Received: by 2002:a05:622a:208:b0:50d:857d:7ad5 with SMTP id
 d75a77b69052e-50d857d7d33mr242507781cf.59.1775694791175; 
 Wed, 08 Apr 2026 17:33:11 -0700 (PDT)
X-Received: by 2002:a05:622a:208:b0:50d:857d:7ad5 with SMTP id
 d75a77b69052e-50d857d7d33mr242507291cf.59.1775694790651; 
 Wed, 08 Apr 2026 17:33:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6cd3698sm5136232e87.77.2026.04.08.17.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 17:33:08 -0700 (PDT)
Date: Thu, 9 Apr 2026 03:33:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 10/19] drm/panel: himax-hx8394: support Waveshare DSI
 panels
Message-ID: <fc5iilgkotgp62aq455qblguh2ktpgqpjl72wxh5oydl4bnkv4@ph65twdn2566>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-10-5e9119b5a014@oss.qualcomm.com>
 <CAD++jLmG_y2dunkyzH7KDtphN6WORzt87f5CpqzAtCUtALv8CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLmG_y2dunkyzH7KDtphN6WORzt87f5CpqzAtCUtALv8CA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: Gc6kexntU3yV3pFZQXSCzsSx2VA_vVVi
X-Proofpoint-GUID: Gc6kexntU3yV3pFZQXSCzsSx2VA_vVVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAwMyBTYWx0ZWRfX2Il8e/pbJVw8
 wmR5FihxS1dwZa/+5zITJSZur3RdxWUTPIlHdn5LgphmJoGJG0hjCODvWM4d7jlK9HuahB+Hmm+
 9gFhpdnMFVjZ4RSgDbbIN/dWFRqEk6lFqUcpmILVu7LVNZgPCHbbclJPEAJ/3mQsRg1cenydVgi
 pry7wPxYHUZeJL8ddNSbWqg+1LKvdjyC0wdejxe0W7WoCQ95ZLviXuBDxpPQ/iXmLswYP3f94Ar
 h4GcxG5cirRgNCvTZ0IxVrcJmQOmzo5kYUfXad8LeTYEqOLw3JyjnLGLH/IgzEABOjeend5/1du
 fA5E4CnXzhh5fkNFGA5zpnQP7dn6SntmCqf3Hvix5wt6+vUBS2oL9uLqiEvfiJJIB4oKWWepYjQ
 jBhbXD4scFaoKMtDUUvNc9X72ZSdTa9fsaHGEC5aVU1n6OWlyIS4nVcd/vQOzbETvGd4keJCqEb
 GBslbKlM/CSG9UjHMtQ==
X-Authority-Analysis: v=2.4 cv=BefoFLt2 c=1 sm=1 tr=0 ts=69d6f3c7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=UUk_dXEGBgzJ8t3P0IwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090003
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

On Wed, Apr 08, 2026 at 10:10:13AM +0200, Linus Walleij wrote:
> On Wed, Apr 1, 2026 at 9:27 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> 
> > Enable support for Waveshare 5.0" and 5.5" DSI TOUCH-A panels.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> 
> This looks excellent, good documentation and references to (incomplete...)
> datasheet. Maybe this datasheet has the defs I was complaining about
> in the other patch?

No :-(

> Reviewed-by: Linus Walleij <linusw@kernel.org>
> 
> Yours,
> Linus Walleij

-- 
With best wishes
Dmitry
