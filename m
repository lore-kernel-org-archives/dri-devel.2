Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87857CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A6B10E889;
	Mon,  5 Oct 2026 03:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B12oK1KX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dAHddn9M";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9916810E889
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 03:09:26 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6950xud03241170
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 03:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=zFKxoIoLm/bREcO/L/7tfh8JMVqxZCAEnJSyOjt6QYA=; b=B1
 2oK1KX0Iws3UwXsGhf1ZQcMwEf4+1/EVEw21BAXdc8m0ble8A4q9rdogvMinyydk
 DRXwZ8lav+Z1ta5GKU8ZV1U8AgDaVX1oJXjeCPa9XPSwCD2xrJjscwSouQDMcGuu
 7YVQ4nWbWv9jZq5Fbbhzp26tvPSvxsH8TQsT/gL44HFHJ8XE7hMwJNiSVZItv971
 0fzylwKMXyxGQqAlfJXXEvljD2Xb30qMNTLhtvkt+GSa463WFqhe61v/RnxBBcyJ
 aHiZjovVL+O0Kf9/Hd5K1Gk5K8BXAnWTMfgfb4TejVxL2K8UJCdKgUomamOv1VMf
 4XEE8ggTQ1lyHNb5eXDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2tvev4t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 03:09:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so237961485a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 20:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791169765; x=1791774565;
 darn=lists.freedesktop.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zFKxoIoLm/bREcO/L/7tfh8JMVqxZCAEnJSyOjt6QYA=;
 b=dAHddn9MNbh7XMabmnLpfU1lfHUNDOrwEd+5cdmt9kzHrr8Z9SMkF6Efn38/rOI+/E
 PCeEy17WLUX5+4H632e6X1EtEE26fXwEJUuCYKC/ijid3m40SWB2RzrVjKeVkmC6hUtq
 KNab1q9MqwasW3oKuYjKXssRToypqsi/y1pbVB2++SUldxD2psNpID0FqTI9PJIYZkZk
 LK1lGhcSjtv0iNGrbnmFIRf/8GnvO1/9VIdsK5zOapqKg0GIMlDwg07U/pTASu12a5/B
 9BtXQYCxOCXz0QucPeK1nTYKNSH+nqZiyuz0mES4tARP6J/cOnAXq22Lw+7YASIiDGD8
 ZrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791169765; x=1791774565;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFKxoIoLm/bREcO/L/7tfh8JMVqxZCAEnJSyOjt6QYA=;
 b=RJ6Dm0Avc/8CRgqtjb0zYQvbahYuDfrROrUXwUKREPRWpTIb5089xFD656qGpX7oXL
 ZtUniuC7OM+GarnJMedd2zYkjYvnL0c5hrSVoZbThTpdsxRtvKK3htPZ507hlhgw6QR7
 cX7uQFLpHzWwydew4WdkO8KsVlR5xsQot6/4KKCuJg/L+p4ub701bQ1XmOyhc5HKGAoz
 bIddin/D7V9lL7soFbEBSUb7zw2u8cQb1pdMSUVCoVg/LcgIUZPNLk+UUFgN5gLtyfZx
 9/oana6dv1AV+jCbJh/xgid6CwA3b2dY1dJbLPRIejRUXOQ4zLJ+tzsf6pU5umP/Gwd4
 aULQ==
X-Gm-Message-State: AFuF++l3GsZ9GmZG4cU5nkk4bqMbPJB5qF9jPO/TQ6O+1f5m/7B9VtKj
 4X1p+wGuvF4o8dmIYrYXFnuC1y3qwbKVmp1DcQxnj1oB/2wpKwMlqe6gGQVfWs63jMNn4Fx5GX8
 CdDYiNQ12QhRkHiyQM0bBlYUwDCxKdm7G/GbV+/9piXMD1zKHhShh5jLva2QgmNfb/n77eQk=
X-Gm-Gg: AYBFou1WRlKeMR+iS6gr+vnTFfC520+eZQDr6Ss2SxnBWdFNXTV4vyTkOwpUStp1jiL
 9jzch0+RGeNn9L1vGntRzSuW4kujFgTE2NQkopvfWhrlnAbdjNYYHWV9Zw6eWKMNi5jyLvR1XNN
 ChIsPom7u4cTCibuwy/ads+p1u2giF+T/gOQSdWowPZgFQ503DYx3AFjbcfZndH7q4AuzMEfJ1Z
 CXduAW+HlGxLy5xHxdXY42KkO4fEGBsLcZtdDtvXke3C4G0sUK8vkA32G/s7sO8oR4cA0GA+cA6
 Fcel+9yCaRkGQNTTckBcno7XRIV8JvygVh+wzTCf9bLO+gLMLZfKE3ew8rKMtjgnp57Pdb7VAFW
 T0Fi6t4RTbGCeVd+TC7ON0yrrEmygoyb3sn6onWE487bjhrUyj0Bn6M6Pm72snGt+bLvwTw9ONZ
 W4ecATufJyhWPr
X-Received: by 2002:a05:620a:28d1:b0:93e:5017:d505 with SMTP id
 af79cd13be357-93e5017ddfamr1111810685a.19.1791169764879; 
 Sun, 04 Oct 2026 20:09:24 -0700 (PDT)
X-Received: by 2002:a05:620a:28d1:b0:93e:5017:d505 with SMTP id
 af79cd13be357-93e5017ddfamr1111807885a.19.1791169764285; 
 Sun, 04 Oct 2026 20:09:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7bb704sm2882812e87.79.2026.10.04.20.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:09:23 -0700 (PDT)
Date: Mon, 5 Oct 2026 06:09:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Subject: xR-related properties
Message-ID: <uyj25irtugtgmcr7xwt4n36ovi6tohawohqaf2mzga2iweuoqm@l2flbkpplzot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: VRxUwy7VGJvoPOczACp-UNNPh4uadNwp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMiBTYWx0ZWRfX0DcZ3JwYwDl5
 bJGxZnJa4+R1HLCg8MP6U21q3UbaZIx2j+iyvr4qUKaGpaTyzqF8vKfJHmIvMh+ZOpoBdM3BF3p
 lXgxgewsfS+jHUepk0K6CN3x9OjPmSE=
X-Authority-Analysis: v=2.4 cv=YoGa1IYX c=1 sm=1 tr=0 ts=6ac314e6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NNc2ktTI5AgkdthpkvUA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMiBTYWx0ZWRfX2YbsQt6TBR89
 1ivG+p9ABJvBWJjgSnA6RewDPLGDqwNPQv8fYU7NsrBgooui0jWNtPepcmAIOmDa2tEMdBVRALJ
 PntPUAYrszNaxjBFy4m0ZQMxsA9NEcjxb701rrvIs6gmLkUZ0NXl62z2s77UaK4igKR4q27ZFQj
 9lIB+SPf1l7NoVnFKUOJ5b4SAiMVey1xDfSZWQpyHvQJ6XQw7lKzt7tYwUhWL/ddEAubRpU7Mcc
 X8FmAnYkS1Wfh513e5jD/9rbHNaHxGLNoftFphxm1xiBUjf50xcuOncjp3pEiN0bPZVKN1v1eBw
 0Bq+YYMX4WHPdSJnx9/TAds0SG1j3/QU8AuZ91KSiuOmXhbjybqnM4qggNUK1oJuIx1Kvswn1Fi
 AAPNZwYRkua4LbmSkQjKF0szSSXtLk+Uo7uGOzvr2RqZZs6CCcm0C9ZU7j6cLqXVrgdQiM6xWSk
 rz573jNylUoeo5zL8hg==
X-Proofpoint-GUID: VRxUwy7VGJvoPOczACp-UNNPh4uadNwp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050012
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

Hi,

During your presentation at the XDC this year you mentoned that the
kernel needs to describe the attached panel to the userspace and that it
should also describe optical characteristics of the system.

Having played with the Google Cardboard and other kits implementing the
same idea, I'd have a controversial proposal as a reponse. What if let
the kernel describe only the actual panel(s) being used in the device
and let userspace describe the optics (in a way similar to libinput
determining and applying device-specific quirks in userspace).

As I wrote, this comes from the Carboard-like devices. Users can use
them to transform the phone into the poor man's xR headset. The kernel
knows nothing about the attached kit, so it won't be able to export any
information (only the phone's panel). Similarly, I think, using
prescription lenses with the actual xR headsets would affect optical
characteristics. Finally, devices like Snap Specs will have some, but
not all properties (e.g. there will be FoV, distance to the screen and
inter-display distance, but, I guess, nothing else).

Having all of that in mind, I think, the params of the device should go
to the userspace.

At the same time, if the kernel grows up support for the response
measures (e.g. performing CAC or waveguide demura), we would need to
describe necessary properties _to_ the kernel, which mean userspace
descibing optical characteristics to the kernel driver rather than the
other way around.

-- 
With best wishes
Dmitry
