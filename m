Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFB7CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 10:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6052F10E142;
	Wed, 13 May 2026 10:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n459xclz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bhT5mQcb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044AE10E03C
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:24:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D4p9T02652381
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ifxChmry+TttLoFTQQ/tL55R4hjUx2mBibZDRYzje7c=; b=n459xclzrhyZI8rh
 ahLpy8jIzNeMLZuEued+3bxg6DPmCaFbTuDq8DU2owZzCvvrn2Mg+DQEPK0c50Sr
 jV6tsw5VvTlwESMA9S09qs3+PVS6VJOsfaDcwntdwxN9WFvJtHPCd7C0HeEilI/t
 sH1V3XnzzIgiYs/Gj8+TdiY1jdoZB67uIypgwYdU3o2cUXp5+tyjSTeIWdS3svfz
 lNG/o4/uUkNmJuGXJH15ZjtvFLzpBu+xyUAOJXBAG2WWtsbenievG+RMNEJZduDy
 5uNzH5D/C4NTJ3bFII9+xEhj2odA+sy5FgUAbF9BHpJpKjfnTpfNYJEqPHxh/yca
 y6UJdw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avm7tx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:24:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5162ee45a77so13790451cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 03:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778667878; x=1779272678;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ifxChmry+TttLoFTQQ/tL55R4hjUx2mBibZDRYzje7c=;
 b=bhT5mQcb4nlH8cxt4ZUwAIn7unqFeNWnRXBEAZh668IOaJQwT7ar8/0hkw5cSSbpNw
 xbZjmq7d023jk01cLrIn3ztBQhau6mgcvn/BFlwGY3X7rfhjoVqq9kXndk5SiDYLPXzH
 9HsBTxuIlvD3S7Th1jsyHvEosH0KQZpCQGszd+kdkEhDwKMQRSbvP6iRQm/kNYWo8JNd
 cK9nBqOgVnAEKaY7p3FSkeDXcPYzwQH/jP39i8fbEWwXiWK8U3BfTGzu5o2pJ9Qt10cg
 6rFVvDfSqUlhBKPLiFUabjOwfMX3eKO9Y3bNvpocN3EF2maYMkiuezZGxF9+6XhoZWMr
 nXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778667878; x=1779272678;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ifxChmry+TttLoFTQQ/tL55R4hjUx2mBibZDRYzje7c=;
 b=nl4hQnsToUxvyM97sxTlWiRJOjC3uR+/NzOqaPrHht8B5c51XJKXPjUIEDFIzRKLbs
 QHeDjFBP/ETC/E0HMSbqoDol1C1UdEsxv4tpbgxYra9or7fKVNukcAzNXU9KGZHsZWVy
 DmmzibTQx1h8gLUSvZImcqPW8YbdgsJD0Az9Wdn5S6JPLmCXfsgnD1NrSV97sM5I1F5M
 2ZjopxWUOeE3hwdLXReBHC6SiEGfS07N5sjHhuRco4ApO7+z8GQBGUWGVjW60CDxHmnv
 rZooVs1DACQh+rl9sI5zj3hfAd53n2khe+2Jm6uZEuquOFWbjhh3sC2yKNRIfp5Z02px
 KYxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Vd9TE6hheGXFsV+0rSgmJq1KC+AE6+Ue9vdYQfDS0u6RODc14z+s9ZhH+02JvrhnA4lK9P1aj+vE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbZ7GvTsXpi4zbBwhnLTE3MfALhT01GvqopBLDM9EjTJRB7wOo
 Ui8WivL9SY5Q6q0f7laVj9+alLVnnMcpBYdGO5MuopqRA4QLTqGv3ixVnDzY55hAL8XmhLbChtC
 RCYJEXiqw8r+V54Sypt8n4GVr8lMG/dxOoMuSfC0fgPNvmfTSv/bUiP0ViZSviYhCdp/YsIE=
X-Gm-Gg: Acq92OE8b8trZM/mP0QUke9O9qoIJIOV3mAofWnxAilcv3KMs0OBLgTDzicNQja45FQ
 fzdlJoep8YVEgODt6+OoKq84ny3lKhL/mTVbctLqyzjTFmoRCP6XW9btFKtpgsIrMIJxQX30Zs+
 yrsqpCrf764tn++C3Dmnflf+blcKZ6jWCvyP8miWvT9oXfVM0HHPOVTPr0S8T+PANuy6u/26J64
 mnVx4rKtU05FxUNsmCsERDtRdTtZUXZkBVuI1NQCOSXA47+WrsXhIXV/QS1xHHNLNd4X/t2XyUJ
 4FRGZykn0Z9Nqi2YwdVTEeOTxAFIw+sir/cE6nYgeEOBAfvPbFLEd1UDG5vjWYGmSNHwl87rhj/
 DkobStHrJpEXhb0w2MSU10rWAzYC/kNWW/leM0wn/x0ptzjvPbtdv1WwS1mfQiBhnUKJvMajJ5t
 sUOLzYZt5LgMNL7Ozs4x4qqMql1n0+evX3Nsc=
X-Received: by 2002:a05:622a:5885:b0:512:e813:7ce8 with SMTP id
 d75a77b69052e-5162f67cf1dmr32339311cf.54.1778667877685; 
 Wed, 13 May 2026 03:24:37 -0700 (PDT)
X-Received: by 2002:a05:622a:5885:b0:512:e813:7ce8 with SMTP id
 d75a77b69052e-5162f67cf1dmr32338891cf.54.1778667877183; 
 Wed, 13 May 2026 03:24:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a955e19dsm3963961e87.49.2026.05.13.03.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:24:36 -0700 (PDT)
Date: Wed, 13 May 2026 13:24:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sunyun Yang <syyang@lontium.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v6 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
Message-ID: <vly3gbft3k76mrcztcn6vxuqadz647hsaz2q7qpmpofowofodb@nnxrr2cdueru>
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
X-Proofpoint-GUID: pIzSPKCMlPyX1bShmAePr1eZAjWZlfF3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEwNyBTYWx0ZWRfX1Nc6V8rsZ3YA
 h7tRwp1TUonMsNVKSh6GwP7fd+rnpcgsmVvISJ44UFMHszJ7SmaBstQG1MF8EOpWNp/2FqqCOFN
 eSWAGdgUUU855hZQidX0fRVUHU7tBB1k/CaQHik5p+usyntZH9rSYxhn8WZoLTnV4ie+4LMGd61
 a58qWxAHSUd8rOiBtwcBX3227jEME77NiEPpLmhSStTmFH6nLruHstgTlaR34J4mmgicKU0LQG2
 /bfeGLSla/44vxD4WshXIsCg5QwiKfXKF4lOau6K+rWP9Oy5e4E0Y7VQ3y9ILfbqnkQnt2NQQ+v
 AREweTHT5r3YWgJStfQ1V1RMwbGVlt0zWFcz4iDg9yY3l40i1m2I0Y1+xmQAk5NEyfV7ib+qjSP
 7ZBOJhOhM4N+nLpL9WKtDHp1Ys2T9gI32/AOmohVBucMaufbS8CkhuUpxc+5HllG5AT0Q6ejf3/
 RRo/X9Tgdek51x6O6zA==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a045166 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=Kz8-B0t5AAAA:8 a=IfaksdFsjFagpZptrvcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: pIzSPKCMlPyX1bShmAePr1eZAjWZlfF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130107
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

On Mon, May 11, 2026 at 11:28:06AM +0800, Sunyun Yang wrote:
> <syyang@lontium.com> 于2026年5月8日周五 22:25写道：
> >
> > From: Sunyun Yang <syyang@lontium.com>
> 
> Gentle ping.
> Thanks.

You've posted the bindings on May 8th. Please give maintainers some time
to react. Not to mention that you posting the bindings 4 times in a row
(once together with the driver and other 3 times separately) doesn't
help maintainers.

See https://lore.kernel.org/dri-devel/?q=bindings+Lt9611c+v6

> 
> > 2.34.1
> >

-- 
With best wishes
Dmitry
