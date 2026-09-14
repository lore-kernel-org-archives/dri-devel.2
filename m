Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDE4C88E5C
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5D610EAAA;
	Mon, 14 Sep 2026 00:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rpu4QKXY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iit47Zxi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF63810EAA8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:50:37 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E062kL4020726
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=asdURPVQzX5whnoLxzBXSnq5
 avohb5NjScAZbrvWiNA=; b=Rpu4QKXY3gQNBMg6lx6rZ31xdK55mimRsuaSryd/
 hQZtTAddl61kn8ty1TCk2sFiFblA567q3CEv1wsb25QIcMqPUQ0+3DJb7sHQ+yfc
 UIiBaTzcXMvrrG7RQr23P+togK4Koyb+GqPm+g0pWZxXjDYhMI+EJFMg8CHJy8IB
 GrLAAFa6zPLb7zTgxi7EIeAKjSj9PZxXtUhm9CLKpODgs5gj8HVqxLBsk3qBGeOG
 Vehy247I8VBID2TjTd3PxpwV5DP90CGNfgxPTrYxzZXB6/FqGHMM41GvEPUjebME
 N/U5xfrR4zjrNqXTVv0yEEqZmep4HHTUMpD+yLDv9S0WGw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3k08abv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:50:37 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78a5a291af3so2349608137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789347036; x=1789951836;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=asdURPVQzX5whnoLxzBXSnq5avohb5NjScAZbrvWiNA=;
 b=Iit47Zxi7zwVzqRoN6oR99wmSCvdVkhQ7nLETNvsLSt51dVuI4QKkenEI+jcPVakHo
 A5GFExH+XemOiahJzSfazyGyqOy1ZFccozrdnFbmg+sd8iNj+jj8B/yfoYRE4MDe54mV
 IcRjO9HoYJoPT30PI+d+1UGN6qU8fqhN2yryD2fE5tclERDUMHk1ziDRDEQJVxbVCAgB
 GuMkJG0aJb4cq9zDXF5VNoKIDM+2fOI6pIC+kj/lovkAYx9eNBye7u5HpjPfzSkmrfTS
 QcD0Oc4dApQuOVQZfHMU56VKjG8inZZkKb/oKZxuxOqK8T5EM1z7O00NudxRKXdBtCME
 zj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789347036; x=1789951836;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=asdURPVQzX5whnoLxzBXSnq5avohb5NjScAZbrvWiNA=;
 b=Fh7g4B+2UF4l+lgaoQLaOlQtkD4+NVCn6MZEWe7zoJ892CAfgJo4JWxf98WlXDGbbe
 9jaoeAv5v21uDDYx6zKxEInKVXB5EyZ9De2VgHsYskMNsv9Sstt977pf3928oI8EvDWa
 cJRHWKpLWZFRc2TOVSRQ3LwIgyJVi1beDVY+Aup3WqLcmb4kfdUno40cLwAjrvsDkA7V
 pxWoX4+d/al4wx4Rh2oYhUyK2aOCvT+aVVynmVDBYAe6HrJD4lzUHHy0DIDsyIlEshMM
 iJ3nHsSgBkyeDyyXVqJMMa4IocOKqHZpPJamKf2YHWSySN4EcHbufTxB5u+ZEDjtwXyA
 PmVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyilv9D3WmWIVTNpemt1i9Ykczxft9kkhcnhciLVwDfOKa0jxwkbKe7lnKxehlIxv5R5KNDhsCfiA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltSJFJZdcIEtjVZw2iWMi+eRmzr+ETb0GyiOPbTUuJwWEzxLLR
 xNPQuJl+k0kgiSUWgXvLRybqhfKKCein0ZujhQuUiKEYWMxDgB2mJTB21PM2dl0qBTi5Djp3GZ1
 IuXuL37nM61ZbuOoaSbe3JVXBl1CbuMGTnOUkWasf/IPnKZlxISBz7C6n4hByZZ+bORA/wgE=
X-Gm-Gg: AYBFou0zo/hlHTN5/0mC2XVgUOIXKdriypXkPcrZgcwPh9xkrRwFJar0JeiL+iglHvj
 5Vir4MJcMLd44t15J9hd5zf3m289LuMn16zTJdIVmdMiL4a3F2exrs04Iyx4D4syxJF76uWMnW1
 yMKJRHh1DVGTybQkuI14c0Wippn9GVNTvJ9eMd7V8ttVk2Jj/BasibkdJRdlEcuFFdSzuCeNmoY
 Y+ZfhjI1pmMcksnpS2LBwj93bPPfrO2dTOcDDP5y/26uKosiPKFX4oPH5mniwH1vL/NNqD1stcJ
 Z7s7M/HpTo2NOsE8t/2uUkyGNJzwmemvh1qcpjV5pVomS6DDDQdT2ToNrNLJOrN/HZTH9vfczNg
 nq/dYqAovYVJrH3xd7xVuu0WogZkG2CD0z7E4d3O9YJJ6aQhpKi8y762UFCvWYYTmj1Cv2WHyBM
 t4Wxc7Qzq/YtTY
X-Received: by 2002:a05:6102:5792:b0:785:d308:cc2e with SMTP id
 ada2fe7eead31-79b5acb5481mr108171137.9.1789347036247; 
 Sun, 13 Sep 2026 17:50:36 -0700 (PDT)
X-Received: by 2002:a05:6102:5792:b0:785:d308:cc2e with SMTP id
 ada2fe7eead31-79b5acb5481mr108147137.9.1789347035856; 
 Sun, 13 Sep 2026 17:50:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a04798d2sm2023587e87.69.2026.09.13.17.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:50:33 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:50:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 7/7] dt-bindings: display/msm: hdmi: Correct name of
 disallowed supplies
Message-ID: <6vmbxuukduj5tpvijgltcizdhhgllj4biep7dqs6twj7qte4cp@khfdliq4agqy>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-7-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-7-87bdb9f1987f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwOCBTYWx0ZWRfX7Aqz+IbCD2qt
 fxs0AIcr3qnC0n3rSTl/Kas7WRC9zJwDHHFxy/d7/wUWecdLvuzlds07FMUAUlBzzW9gCuKVitG
 gurkRKT0Jsra5rfdWqBDE8LygzKLzvw=
X-Proofpoint-GUID: j1HbN03UBHMNLa2d0GpxYnCR07y4esfi
X-Proofpoint-ORIG-GUID: j1HbN03UBHMNLa2d0GpxYnCR07y4esfi
X-Authority-Analysis: v=2.4 cv=BtAIUoX5 c=1 sm=1 tr=0 ts=6aa744dd cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=XYAwZIGsAAAA:8
 a=EUspDBNiAAAA:8 a=5Adlwl6woCA7rngLHykA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwOCBTYWx0ZWRfXzs/lcp1wrfWW
 xYfwCdBOHlDI+0TowlOjjTbzluby/oAMZE8EDxSnUP4roRVQASDD9zfGhxicY/F6BmKZknAjAJn
 uMmLU68DBlpueaLj65ec96/IBj+XxT9H9AiNHupQDz4ZzPWCBhfkp4hAWClajiEGlZAnFBxC5Za
 SVHDlvTiHM8vN5lqMSfY+FoXpKR4EA7bGOaydDl0ycjvFeUK5W+g076yB9jciYYWN4GNS5GcZK7
 saky83yIEwmCYcZ1r/E3fKVoO88MXGhwt+Mw/BIBWOko30LF2gkjFo1+xozuCBZS05mg+TYkidh
 ZDkGiNd0CX1K+CUVjrZSGQM3I1WCFza46ARVxnLi8ZJMnBpupdsCQD+CmPXBHjNCa4c8gXnUTQO
 UoruEVvKcxcDsuF41va/dlnQym4WXTG2sr648a7euNjxe/w05yG076rzG/IievOVsFS2JOJyNl4
 9llTlm5kfMmDM1/ciow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140008
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

On Fri, Sep 11, 2026 at 12:29:40PM +0200, Krzysztof Kozlowski wrote:
> There are no properties in DTS or Linux drivers called
> "core-vcc-supplies" or "hdmi-mux-supplies", so the binding probably
> wanted "-supply" properties instead (which are defined in the top-level
> properties of the binding).
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/hdmi.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Fixes: 2f14bc38d88a ("dt-bindings: display/msm: hdmi: split and convert to yaml")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
