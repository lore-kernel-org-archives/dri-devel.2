Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A4606A321
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LipgI+45;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=klKy4tOz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A960110E643;
	Fri, 23 Oct 2026 14:07:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D1A10E643
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 14:06:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vnU2109062
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 14:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CIGT6T5jpQ5FmUlyBZ4+jWaj
 UL9eR2jOzBgtYvKHzIU=; b=LipgI+45CzIQAaLn0Iqy8z5+4xdRW4IMx5NjkckG
 DLOzCswr8mZKejBi4M3evK/BQ+VjB03INlKZFPRGoludhrQG2LqN3W6RuJFKBnXx
 vgKYUtZmDY5xb+HdjuOCWLe0YO1p+HYibIZL2ngizrgjkhh6HDjz0ObaaoRJDXeQ
 ezpqLeeNo/pSU0wKl6WgE7CjCXsfdNI2bB6dUwiY7LPX4vyU5wuB9uFmc3+8Mjx7
 tMxClPG0Uk4Joj9pwietnSZ1sTRW36qqMn+yBkPp3EjwcicLBfGcfN/BUGAK71ok
 LQz1Dh3ZS+d60lQjVGwhm3rNqRnYOuL0YqGjhpP/ALH7aQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms408b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 14:06:45 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7cc10da5ad4so234592137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792764405; x=1793369205;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CIGT6T5jpQ5FmUlyBZ4+jWajUL9eR2jOzBgtYvKHzIU=;
 b=klKy4tOzEdYmizye9fHUsV9ufiqYZr9XLGe9TxXobaOtIUeBNJJFLTvsz1tU8zoIMn
 rsrxvKb4JXQ1aWTOFTdBI5uvCJ19WJGOirh5fQRLf0+TBcIK3xd7H9GfWkr208ehNcKo
 IGjb66SfzK/SHZ6d4SISnzJ4pIT+RUjZH6nGKe7ivQ2SiOu/U4/Ig0wuQr3qDBb8fNk/
 QWy0AHkho6q2WrVoxvxIKitqqSfbJTQEBE3O2DKqD+6uhXbzOQGfbF4TP6QXpgOuOvCG
 gisHvCILUzLFjp9Fb9K+XDWIqLgz9To664DRPdSpFyvpOfUmYAx4WcVcIWXR6i/rRdxG
 fHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764405; x=1793369205;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CIGT6T5jpQ5FmUlyBZ4+jWajUL9eR2jOzBgtYvKHzIU=;
 b=UB2q0/THCzIYb7gI4ZUNyUfT66GtBJqA4PFySFJSfLpCYhmUQ6Tr9qhmiHMMUVXGv4
 rwi0I41XVPuSVTpgmdq04YZnVyxsEoynB18oswcYciEKad0pTHrDt1797xBe56WSeJan
 3hFc5zt67MPaOjsf8dSTNCsu+6rvydaHjeBWrHkGIg1UTkDHK2fbZPnEtl/R4pobBNNx
 dZwtPE8AVf8JUnCXNUQC5t+rgPrHfSxVtzpLbEXaY5YhoSIvgucxN0l5YvSxChUnmdh9
 pVCUqIzyqTESaOZ7Je7RFeoiV8vsA0THa+FjODthQXex/KJhzqeAb9fhEviiNWXMwpM1
 kfnw==
X-Gm-Message-State: AFq9FYKa4wjclk/qd47ILbtMIAAKmAy8lFXztLA7V28Vo8DGs+xj1S28
 r0UxGokCvyQkEXKafQEZUh0vUBJhRdwg+tKIvz7DkMfqtmMmax78SQoRwZRDbhFEri69sXCKFpl
 3oPcUdiGJez/UQrgyzB+NkGbV10YUer1XkZa+1gbiLGvABOLgeZnbyEUtfPhjjOuJ0CPTzTY=
X-Gm-Gg: AYBFou3WutAtFD/MgVbydZPAy/XzhyfRVv2ZxUUUacnJEf9qApKtPWMAV8CKmBEQkjS
 Pc8sNhDMJ4zYm5FI2rGEMYqKnHWUQ9+vLy13BageqmU4wFgcx51a07A5evx5aljGEXiwAwZVjVC
 xdJKDiXSU2xnMLJXHKiq8fA8ZeuW/fIqll+keQrhpGWwiUQfs2NHLtDXtNv4gcHlT1T4ab5yoAw
 QE50rXZ8SFHktau2T2Humt1DBNZnL7qMWWAAcHgorqEV+gysOA+DnPjMBIwD6gyDyD1Iu9o+S6U
 cYJ4ZpwQGRRp3YGjYOacSZ9ekexB2qExe3x/UWYA04VJCtyHeIAns2k3mdYmf5s7Ce/s6Ua1YF6
 b1S1ZmnW/BFT0DkckLGgnc2uN5l7/yKcIepeJWEl1OySrZellIGJJviLqG1oeuaZg5Q5of0IJLv
 J8Eoc55vKkFmpT
X-Received: by 2002:a05:6102:54a8:b0:7cc:226a:f963 with SMTP id
 ada2fe7eead31-7ccc33f251dmr903856137.28.1792764404672; 
 Fri, 23 Oct 2026 07:06:44 -0700 (PDT)
X-Received: by 2002:a05:6102:54a8:b0:7cc:226a:f963 with SMTP id
 ada2fe7eead31-7ccc33f251dmr903816137.28.1792764404087; 
 Fri, 23 Oct 2026 07:06:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb027d282sm401608e87.42.2026.10.23.07.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:06:42 -0700 (PDT)
Date: Fri, 23 Oct 2026 17:06:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/bridge: display-connector: Support hardcoded
 EDID for VGA connectors
Message-ID: <e37zh26agih6xocxiimewb4eulrvmuqrrb5gtrtmrix3zcsihm@3e752rnht5hu>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-4-laurent.pinchart+renesas@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705213542.28987-4-laurent.pinchart+renesas@ideasonboard.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NSBTYWx0ZWRfX96pd2RygRVfd
 snfsiCOWJ41hxpxC1s2txQoC54ScD3+lGa8f8dKX9XueuXrSGz7K49Mgy889Vj0uFgBZb+nWFIQ
 U6987lsTpz1PKeVTP0ABbKTcuDFrgwx4lZA5l9fNZvzkxiOHkHfx5l3J/k69QMLsjaBgef97zZV
 6+h8XbGJVlwGfaVLa/2K6Lja4Q6Rtvb6OVQFxNfSZnsDL7I2wuJ9vHPSbQuIpXzRGhZuA+LJAGU
 4N+9zX0xTlRkdxT8/nA+W+azB9alqkG3Ioovo3hSkVoJENh77fc+agTEYvA8K39crIrnNSnjmdM
 mb+FWhX+bwqQaxR4sV/Zz4i/QzNKsjakiHp+uzQSg1WcUsEsjrnrjw8wDRDxfLfq7R/8itjItOu
 kPP1gAv4Zu+3cxr/HbE9ebQsyZE5CeJfLLKyPvUDM90/M1yzXq3yT65sFXDDj8RJVVhRN1Mb5uq
 US2H8AzyPKgTodVs7AA==
X-Proofpoint-GUID: 6ju6tj05qd6G6vNJGlzyd6wEDgpgeOMO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NSBTYWx0ZWRfXw0JPpwfGc4/G
 FC6WpfqdCkGjloS9wJZGzgkuHGDQbbBY8AH/hxyWmD9AXp1M2OqiRVw2wDVyBJxHOKTpXT1EY29
 B7UBV8cd5xlMLSiG1o0B6fqET1QM5Hs=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adb69f6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=P1BnusSwAAAA:8
 a=uezD57GckRT0Z6Tr3-kA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-ORIG-GUID: 6ju6tj05qd6G6vNJGlzyd6wEDgpgeOMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230055
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Jul 06, 2026 at 12:35:41AM +0300, Laurent Pinchart wrote:
> The DT binding for VGA connectors allow providing an EDID blob in the
> device tree when the DDC signals are not connected. This is useful for
> devices where the VGA connector is internal and a display is guaranteed
> to always be connected.
> 
> Support this feature in the driver by parsing the EDID from DT if
> available. If a DDC bus is also specified, return an error from the
> probe function as DDC and hardcoded EDID are mutually exclusive.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 31 ++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)

Having stumbled upon a similar issue for non-VGA connectors, would it be
better if this is moved to the drm_edid.c? We already support
per-connector overrides and then loading the EDIDs from /lib/firmware
via the edid-firmware. Would it make sense to extend / reuse the same
mechanism? For example, enough of the LVDS panels come with the EDID
(and EDID lines) being wired, but in some case we might want to supply
the EDID (via the DT or via the request_firmware()).

-- 
With best wishes
Dmitry
