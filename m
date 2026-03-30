Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE308FB3D02
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AAB010E5F0;
	Mon, 30 Mar 2026 10:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZZ9jOsB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UxnUZ8JB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9592510E5F0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:34:01 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U9nNaY3722208
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=k6UFRPpSk6O7FsltyYeNMfVq
 bWSgj0v5jSe9gEmsb1w=; b=eZZ9jOsBH6bmI+kMymxAGJxEqFSjVdN+9U8c7ps2
 4RrCoGOLcZLAqFxfnPWandOFGa7270fhwtK7OV+HA425e4eJkLKU4hdPiXzeLVCE
 nVk6lk2ZKHT/PR7ssglJKTqIpRZpD+EXqylSUtxForcjPgR+Y9uymzFeed9EvfaI
 o5b9XEe/ul7JaMV7OkdVJ75xp8S1rOPaqyERCKIxWb59teK5xcdqegMe6iWI96bt
 b0xdPZGKMWGOIibv6HyeOIe6mJUqOD0o7xM4BlYJbzBUov5mgo+8OitlCjZimlN0
 9+1FTP8aPDc3Yw1feebwd3rBIRoJW/mesVpa2D5AxX9IJg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmr5m7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:34:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5090bc4823cso82134761cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774866840; x=1775471640;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k6UFRPpSk6O7FsltyYeNMfVqbWSgj0v5jSe9gEmsb1w=;
 b=UxnUZ8JBE+pHeuz/U9M43VxuLwSpBerb80dtxkIe86PCJ5/0lNKsGTi2GvA0JS1PvN
 2pW4MaJ+YXMvED1wQAu6S5MODqPWha2Pts/8EkeWwS1AdBfCLRWOc/BEIrBwm1DQVWtU
 3fpQvqqt36xgm1cu1yAMQlEJVZsNxgv5WXnfJPXq6a6EARPmvRDf4cDBEdpCVK1EtGOL
 V85GsE6nHGqOPhmpf+SKyxz3Gz6GThbynRKyWW2YhE7tIiH3/TV1OE4BV7KP3OSu15rY
 Wmwyichfjq8KNS/Z7ro3d/t8FHzaqKw7uRaldcx42ra2HFyxoleEhEvJvKpFShDesE3j
 KYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866840; x=1775471640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6UFRPpSk6O7FsltyYeNMfVqbWSgj0v5jSe9gEmsb1w=;
 b=Cn+m/jn4GiGfjtPaUR1f4u+IuIYTSfoahegIfN4PYEFFwHcRLZU/ES4BOK6/XGExMZ
 OGNYCEdfz87MZyOR8Kxd3FmEt/LCbAb0NTRF2z51Q4+5/j7HDqxQAp2BDFcj90OWe1j3
 IkXrMhAmiY/gVYz1Bfl7lKMe3GNvXl7Q592gZe4hA/34ZLTil+bqnEwheDX1bZllLLV1
 698sT8N+RhHuKh62NAPJmCbAknI23u0xKXPpZ/rY07ou8Zjr0xQDoZPXtWVohqlA+cEf
 vaien8MOrDsUBD2/1kgfClWx4w9wjqfXwSs0b+QxwIeyRX5cpDycy1dWkkk1bCd0aS1c
 F1cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVODcz4Vfzom44tP/G9+QVdMhmU2bddWJdhZonMDdidW5hm3K7T0RSXyiwIRm7H4xGzEA6LlK6Bb6Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw95PiYht2P+O9gDdlcIolyJBq9SABoe0ja8023a/+JP/Zjq7p+
 r3lYpZTL6Gljg4QLHORW8DmpuRJIqSbxW1jm+UJKV80aLxHNtV1UjD1jhWTgeYXmIln8wlKzUJ7
 vXf4OtDycJatMhoDEOeum380ZAbufCPTGDzFjMWxly14OChbLn2uo1zsONgnvt7TBuIMGfsY=
X-Gm-Gg: ATEYQzynzt/PIPL4vagW4lkD8TMhddhIbC6WEbDcXUSthffyWSGdqF+alZ42EifDkWc
 gImEyQQ7ExxwupsWr3nl9XUaAzkg38KebpQsDEAvVC8yXoOFmZOqW4Ur4ko7YEuOb3bGgTRAlaY
 iehg0BXCcx/mseOTAW8satrtUQ/XLVENdZs8T3wtTK0dIKVj1KA9HJW1IUqAgjM8ekaweHph7zS
 odjn4eeW4pI/2S/iGd9QEMXLxwnnku83XaU56toSdRraQg5sKl/lqoDE3CgBtSBPIWgKK9vQUVV
 hMyZcT29Di/0rCk9JW6qZe37+hrNf91p4j/K+Nv7B0g9CNLlZT+4W02C1/M1LRlVca6DBSsD6T5
 t/bmaDO+G+z0Gp9PJJmzPxVxgdp934mB2LB1kfOpzgzveZR83YsseWquaPkfOuzqUM1yuaqTwhK
 7ecYWou0V6G+WVD0Pfh8btOuqJT1elah1ifgw=
X-Received: by 2002:ac8:5a8e:0:b0:50b:47ae:8abd with SMTP id
 d75a77b69052e-50ba3809620mr168990851cf.2.1774866840124; 
 Mon, 30 Mar 2026 03:34:00 -0700 (PDT)
X-Received: by 2002:ac8:5a8e:0:b0:50b:47ae:8abd with SMTP id
 d75a77b69052e-50ba3809620mr168990471cf.2.1774866839717; 
 Mon, 30 Mar 2026 03:33:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1443f23sm1626352e87.42.2026.03.30.03.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:33:58 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:33:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 11/38] drm/msm/dp: separate dp_display_prepare() into
 its own API
Message-ID: <eemnyjrkvubsyuwvpdxtmrxkba64lxrpucdim5nihlfzijxbvk@hirj2yjvic7s>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-11-01faacfcdedd@oss.qualcomm.com>
 <rsywfefrwv67umbi6xeybelsu5u6xqyklvtarnoluu5mzz5u5k@bkexqpdd47ew>
 <52455b77-fc3e-40bb-9462-8a78238bde0b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52455b77-fc3e-40bb-9462-8a78238bde0b@oss.qualcomm.com>
X-Proofpoint-GUID: dFO_v6YjhrMg6h_1UDbdiXbpOBSL3HNd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MiBTYWx0ZWRfX3J12PWP8xdFi
 bqAXAFcsLwDBrByoWj5jjw2Bo6lgAlx8zL4QvtSjdGA3E8MSWbVd/n/H2thuktXWsB9KlVB3utX
 zVY89PBA4mB3FGGj9cTsAB/8W8Sm8oAh+zFvp1tSyhkwy19+b3XN8AECMvfAHhZgE4ZHAGjSyQ2
 /mUMs+IwObKrOpTJqo58sEySkd4Huc0Cwg1st8NLGg3hZOVbSMxvQZfnMURjRCuMHBr6CMD47VU
 Uh30J5CNUcf9bebmPDUi9mp53QD1/2quzvmHJ5Pom/gTj0UKRcm4nED64edKw6NsAGnjrhCOAJ1
 bsLqZig6sXukRWkGB9V/prEWAmuRnianiNjC6ma30gIV7hW+VzVu3N8DpLNciaxEinBoJsQCfhB
 HxXiowo9qFjc4CzPdlojUajqnPXqX2MkDv3OkXBn7E+1I5UPekwM3wDoePibCE71vllY8k2oKi6
 h5DYNlaf9guDBv1wkeQ==
X-Proofpoint-ORIG-GUID: dFO_v6YjhrMg6h_1UDbdiXbpOBSL3HNd
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69ca5198 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=BmG4Nd5KL32AyuSnXtcA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300082
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

On Mon, Mar 30, 2026 at 05:46:09PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 1:39 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:15:57PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > dp_display_prepare() only prepares the link in case its not
> > > already ready before dp_display_enable(). Hence separate it into
> > > its own API.
> > 
> > Why?
> > 
> In the MST use case, this is expected to work as follows: when multiple
> sinks (two or more) need to be enabled, dp_display_prepare() handles
> link-related setup and should only be executed once, while
> dp_display_enable() is responsible for stream-related handling and may be
> executed multiple times.

Then you need to write a better commit message.

> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 16 ++++++++++++----
> > >   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> > >   drivers/gpu/drm/msm/dp/dp_drm.c     |  2 ++
> > >   3 files changed, 15 insertions(+), 4 deletions(-)
> > > 
> > 
> 

-- 
With best wishes
Dmitry
