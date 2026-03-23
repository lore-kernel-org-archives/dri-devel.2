Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09492D58CCC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 03:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB3D10E33F;
	Mon, 23 Mar 2026 03:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gpNcdcbU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CNRS6JXT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC45310E33F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:34:48 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MLtban3385863
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=L6P7AUuJUNNKnoKSnfqsIhB+
 EmqYHXSmTxiQ+qim5ew=; b=gpNcdcbUYYmoC8B/6K4Do6y13gNQuFB/WwhbWVU4
 EgHcW6pKn7ijAew/mbzN3IJEb0KY3nQD2wb9GH0r3BdhdGfQ1lt2dblx/KugVkTu
 yzzU/PyEO9Rw17NIF2/QyDzKC/NoW7Zi59rOUOerzY01rtSjUTdugFUnrTl3oWH2
 TKIk6hlXlCkLTeB5FIWYTx+OGZLu/27gx3X7MD6477JE4VweOOBGVpZsprV2mj0V
 kg7dO5f4YjGKv7CIPWsuIvDrd0mU1NRJH2pl6aOboSaIN3w15cfcjbRSYxbEmISR
 5+TPztak9rSibJucAFt5ycLH5TAJS9bUENr/uU/Hb2zxOQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d2ca8hh28-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:34:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50925fed647so323087741cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 20:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774236887; x=1774841687;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L6P7AUuJUNNKnoKSnfqsIhB+EmqYHXSmTxiQ+qim5ew=;
 b=CNRS6JXTXE8wTBmTCIeYUWRrqGt1iJNiaqsjZiftv1ND2yAM+UseUdMs6kMVVNGBNi
 NcDM4wRLggLc41oKH3lsocngglEshQoP4Pdvt7VkSUZHDCWYfqNRO9NQUAEb6HhAZQAX
 3IsaTtd/kZrF/OfeRxBEwL+SDDK05koCZG70x2lG7VM/HxwM1s0W2GNplm5w5MQv9g/m
 lJTWodW6QkVWNpGd5Myoy4HLlzdWsLuAWp60kYebulZJHW4e6+n4loQ2LugEpe0FyIQT
 JnDSb1Fg/QB+UrzcXrH1hntIS2qMdxo7vgKvt6Cez1Aspwz2VkHU9F5Y/7tyBctq53tV
 9iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774236887; x=1774841687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L6P7AUuJUNNKnoKSnfqsIhB+EmqYHXSmTxiQ+qim5ew=;
 b=XM5DyTAaxulqUB3ak/eEUAPnrU6vpoyRvJaopFcoJN6l/k8wilPcxbdn0NtJp1daJF
 2lYzRt7shKR8jM0gunF9nxWFqWnmlNrVr6jYaRXfbb30oCf6KbD1kEGZYD6Dqlj022Pp
 Qxcb2bywEhOsAHggM4iaHhmNbGj1ipGaVzrZCYUnS7O9Ys/zg0R5OAFZdmf1hqRMNjzo
 olG3Wz3AiaSJiJ1pxmOuWSdY4y9z2ZOUxZiA2cxzq54YEIY+9JMNnjsC4vM23swfbow9
 qxa27aDlNzTbL9Pz8mCLoHbL3c1jUB7kYf12uwWbKD/EkMIdqSLLwJYXyXNiJIZcWVLn
 zKlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmTFy0hcyEBQcxw2S91wABMuR9F9WdBglMn/46qOzEeqG2weWuhPnSnv1mOXyOk4rBhuRDBvEOx9E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHCnBxzckqfjWry5Hqwgq1Jv3bmjB1a/eRX1jyITeAu+FHxTtr
 9PQXp93BYSKYKU3wJ3dlSYjTbk3TLeYBNAtv0r17SPe5SNBJ9pEYM0qT45BBRm+QF3CtbMDFmP+
 fTTsgGYMiXi56S6u6fTIjM4mKqtXZgAMl7GCdTRaOT+SW6H/QHtuVBqsPc0cVK644pxOg+0g=
X-Gm-Gg: ATEYQzyWMF0ZdWBCGjFQe9gHsqfdrV5m1SMMgEglR+9g5l6+jWIUnhGNbOUcD0YUzAr
 3F4MzooyFjhpe30D3eq6tTe2/c3PLUFwzMYOK8vDGeRWXR1WnmWcxqGILpF653FslvEykHp5QFM
 ofMNI6Z4M48z95dtV59Slkw27a5BnuQ70KNx0UQ8/5NsHsuvB0ExXJky4d7K4H5Isrn1USYq8KA
 W67OvLl8ZxDN6AfWkuD0B1yOfS9biIJVueUpzZQEL0imjHZP9aY6oT5yF1Fhs6Z8vNxgPwmnEff
 JjW6m2MBl0vVkYWvaxCnPn4d+g3udagg3FAVT3yqFN7DlsFr0WkYZuJ+Weo9J0ftCwZGr+g2ryF
 IHyVpC2o+B5/eGuxYf9wScBkjRcB+WcXlhP79WhAIECEZLkIi0o0m1JjKnSa6T3y+p1ZBMU07M8
 z7ZaUjfKri69NnaUeG6rJFSUPXgbVpG5rOv8o=
X-Received: by 2002:a05:622a:354:b0:50b:51ad:35eb with SMTP id
 d75a77b69052e-50b51ad3854mr70154111cf.20.1774236887353; 
 Sun, 22 Mar 2026 20:34:47 -0700 (PDT)
X-Received: by 2002:a05:622a:354:b0:50b:51ad:35eb with SMTP id
 d75a77b69052e-50b51ad3854mr70153891cf.20.1774236886880; 
 Sun, 22 Mar 2026 20:34:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285192b5esm2221882e87.16.2026.03.22.20.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 20:34:45 -0700 (PDT)
Date: Mon, 23 Mar 2026 05:34:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.Wu@ite.com.tw
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/bridge: Add ITE IT6162 MIPI DSI to HDMI
 bridge driver
Message-ID: <raiofuwt3kizmnkadsry4ttiemv3dr6p4iydvwfond36fx2xbq@ugrw3zr2agqi>
References: <20260313-upstream-6162-v3-0-8497fb7c4406@ite.com.tw>
 <20260313-upstream-6162-v3-2-8497fb7c4406@ite.com.tw>
 <i44ock4tspw2244xuagj554d3giko2ck47smcic42glwrxwc2r@s4uj5w6xagtb>
 <e76a20e92ad440e4bc6854ad444695dd@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76a20e92ad440e4bc6854ad444695dd@ite.com.tw>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNCBTYWx0ZWRfX1yNilvfuF2VZ
 Bzin6ieot54X7ZdVvWIOwovzZpEeYdT2huPaRtF4BGZDWFAmEQK3Nw1oAzJ48455jdUvFhy+7kj
 tyYuocMwdvC7gXofyVlxhKEa6h+9A+mlNpO//1pB3nlYWyXUG9gi4DX4J+TbTGJUaJOtQ3M++we
 Yd3Zs7MkBCqySa60wsL5i5DSLU6JnY2l35uixYe82TnveraM8NeKm87RSBOVDZsOcKrp0Gylqiz
 SWYuTJsrZzGVnekdnrE4ye1TKIGi0xVPMZDjuL3xJe5toBOqZd1V9JJrC/0P5aWRA5A27092NUV
 E4K57coyFHVksl9v1kN5ohwCMB0v8iAZuJ9XA4Den//JUfuh93nb+eJCjIxOtCvymJ0HiF9f+gw
 HxJ4mropus849fDw1bTCz/OrMqMXCAZhPefPoxKIyH9k6U/L+NK3xjP5orEb430/6Oc7l/S5f4z
 /3l/HzkcyY7gniz+DlA==
X-Authority-Analysis: v=2.4 cv=cf3fb3DM c=1 sm=1 tr=0 ts=69c0b4d8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=Ns9eNvu6AAAA:8
 a=TUF5HNPNit4jWLsqbl8A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-ORIG-GUID: 17NxTTGgJZg93pa-OFRbYHMwK-ITZ7bI
X-Proofpoint-GUID: 17NxTTGgJZg93pa-OFRbYHMwK-ITZ7bI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230024
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

On Mon, Mar 16, 2026 at 02:12:36AM +0000, Hermes.Wu@ite.com.tw wrote:
> Hi
> 
> >-----Original Message-----
> >On Fri, Mar 13, 2026 at 02:16:01PM +0800, Hermes Wu via B4 Relay wrote:
> >> From: Hermes Wu <Hermes.wu@ite.com.tw>
> >
> >No HDMI Infoframes support? That's really sad.
> 
> Is HDMI Infoframe means HDMI-VSIF and HDMI-HF-VSIF?

Currently we generate only HDMI-VSIF

> >
> >> +
> >> +	.hdmi_tmds_char_rate_valid = it6162_hdmi_tmds_char_rate_valid,
> >> +	.hdmi_audio_prepare = it6162_bridge_hdmi_audio_prepare,
> >> +	.hdmi_audio_startup = it6162_bridge_hdmi_audio_startup,
> >> +	.hdmi_audio_shutdown = it6162_bridge_hdmi_audio_shutdown,
> >> +};
> >> +

-- 
With best wishes
Dmitry
