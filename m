Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB34ECD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3690110E5F5;
	Mon, 25 May 2026 08:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebFSXMox";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N5tgaPoM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC2010E5F5
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:28:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P6DlWo723934
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BLppBFkkrTJ9DihnX0lJj7ir
 Oe9XAXyw3RAwRnSslRc=; b=ebFSXMoxFbFObAypkDqxQJPVzyAx8JR7wzI3jplF
 PIYAc9+s1D7EwDMUA8CZP+50b8ogDG6WNtEiVVmMZmki+xDwixDm48OtQHfCDPyB
 +t+xFEjBcZ42MFfo6tKU07K2HSHY3PNuagvPGcxL026BTDIAJJiGegKJh2Uqak5w
 x4a1hBGVnh19zhBB22cad6uZZJYZ0DPw+5Tlr7UIoEZOJy4lbB78Wvu/3b+5kD4m
 G7k94LxqmSFPjMKjLGAa1fhftEK6fo6sU1J2Awjk25zoz3Va7Geb1GrCfrtb43DX
 sMICmizXhAFgDI+YC7nO0jDmEie7pr0sZoIoHpY2Vs+jmQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w58mc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:28:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516d09e77e6so72486591cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779697732; x=1780302532;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BLppBFkkrTJ9DihnX0lJj7irOe9XAXyw3RAwRnSslRc=;
 b=N5tgaPoMXbN4C5uAYq/dosy3c1ilH92JvRiExyPHz+9wsWLxnonLd2koVpEtgx7VsQ
 jHGwN13m6Xy6Rrol6thVg3rsbFZBnwH7BbDtqRvGQXt1G+gJGAuwMuriFRlxqKHYxkLf
 axY0KN83a6HyM1EUUho9n3+UXX7yvVEHsBbSk6qz5UCwCFDvTx43/4aN29d5m5+3aQjy
 v+UFIcG/2AG9RShyxJgZftN4ElNHpMSj7xKkqk1ONL1QVaiR1e4c2dOax0EDjobD9f8O
 VXznuQattqAPOOVZE94Cfrr4JWKrEeV7Sl0gSaluyi8Tx+pUlcRkAKQ+1phJWhxmTwFC
 dSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779697732; x=1780302532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLppBFkkrTJ9DihnX0lJj7irOe9XAXyw3RAwRnSslRc=;
 b=ehaivl0f4VkOPVqxrL1GOv4JtDabEJX1rOmyqPVQZdXd9FEiXCfaJSGYCWWqSceVzN
 PDUUYrhwdvuW++TBvvioeBB6tmegYm0e2my68R/kr0zX85VuLcvN4IPBucOPs4bL/IJJ
 a69fpIKs1/Qq3FBnCth1ryx01c32bxffHM5z+D2rRNNJG2MCKuP4xC3ROEqa7nDoQEAz
 B2A+LqWKXvjS3/iHAeR0jB2Qk5rNh+kpisWvYWL8QSsm5sfcHpsl/1+NCbJIOhyr0UJj
 S0iG+TC+WSfw/EZR0xmOugrnWjJgecFiAFFMpuQ/HaM1A4yK6+zYEXryCBJj29d0ZRKn
 Qw7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6vVhojyCpSjQITrcVaLj9C+OGJnTMDYALl3OAFN8boLw+sZFvMCWd91zr8HNNPueiAD4LfP5wC4A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+orT1jBKum9hTVGiRGRMTG07tPNZgTpKW4TCQZqmHjBjhDieH
 VILenJAItjzgWvkWEEw9snckgb6XdzgewpuW3iSWFer281xaO0hmeu7MeYMahOcdbyqTXXCU+9K
 GIuih08ivDVzEawPC0T0dSB4I6T7lH1SczYu4NG/ALMtVbQFxKzfZyauZw4gwMd0kbkD5gkI=
X-Gm-Gg: Acq92OEr9rGK9lxqfAgwYmRnzvCUd6OlmJHi/8qUuhtFIG5m/gmbFX71nm1fsqQHLvm
 kFgmlxvBAlTl/Yu1J04dD+ognjT1dRSrQxOYNmG/WTxhDNZIgA12DDk0iz5lQT1DwSHOu1BiB5x
 Y1w8dpzPAzKnsMgVW3vfKlKTVqSDndJ8eOrB1P+H+u8vg3VPvOlXRWKOucnQL4vhaaph1CdL5/8
 GnfertyL9YjnZ0qJNt2qHWlZSOKxC1DA7Al4Z6w/gQIG0RFczEYOtofj4rkOkWSwLWgqPXumaDP
 238z6FadpebeOv/pvlcwdgHOTrOysnHSdKEE2HqrttS1QkQ2oLKLhuCVKVkwGW+gxvGo0awTa/E
 DVLl0wWF0UAz+5Ze7CKHNrMCpUPF1X/5mrwRmDrwd9Ez/P/ytP9OBK3fR4r7Kh3HDZUu65Rkrh1
 5QuMBnfQV0TFaDBh1JQ+9Dajvg13uECwE1w6M=
X-Received: by 2002:a05:622a:6115:b0:516:51da:ae52 with SMTP id
 d75a77b69052e-516d43cb30amr179921241cf.33.1779697731660; 
 Mon, 25 May 2026 01:28:51 -0700 (PDT)
X-Received: by 2002:a05:622a:6115:b0:516:51da:ae52 with SMTP id
 d75a77b69052e-516d43cb30amr179921091cf.33.1779697731225; 
 Mon, 25 May 2026 01:28:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc4446asm21334871fa.39.2026.05.25.01.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:28:50 -0700 (PDT)
Date: Mon, 25 May 2026 11:28:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, amahesh@qti.qualcomm.com,
 arnd@arndb.de, abelvesa@kernel.org, jorge.ramirez-ortiz@linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
Message-ID: <wowscekybeyxjgoztvwtgls4s7pbwciiztsizyc6kolxp4g72m@bfy32b24zo2s>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
 <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
 <2026052211-pavilion-compost-5fcd@gregkh>
 <d9248bf3-ef48-4c04-ad7d-debc8854bae5@oss.qualcomm.com>
 <2026052541-moaning-dioxide-d5c7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026052541-moaning-dioxide-d5c7@gregkh>
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a140844 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Wl0GIK3KD4wLFu1QXOQA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4NSBTYWx0ZWRfX7uomUgqgH07c
 QtuE30zoA8FHI7iEGuwexcOQ3O8xp2IYIvU0M3gIn9Bkqobf2SraPeAup3C+Fx8gtd2IdgHDWUB
 r4+g574X9RxKqirxDEMFssMKCrCPlDzzDy5qsuTjVwNmySiVYY0ySjFvIjyMy69rFZJNcT3H3+l
 fXg74HQiD/WkdV4JtIl7NaRbpaF59a0uoB1+wMQOKeXxHVF1MbjI8LEUiZ+5FLpMkv5NeWAHYG1
 1S1+qbxNQNHJ92HkqOLwEWJXMhyxH3R6MPCq0Xszb6vrv4ImWeUH+w3uMGdqLwTiINP0/sanMhI
 W1Wqb6MRcb1vzbAKCfgpZQ/TzwKgUrnWoOGtwut15bhVEu0mDyK9tmG6SKlT3fHMGPSRKbAiA1M
 qBUS0ZEXixXrkcIlBk/6odogg6QdMafrOeg6B/GnHMBKDd/jJke47OuH/t2uhOHb2oRKW5TUgqz
 8BfhMIIvFCPbIIAMlMA==
X-Proofpoint-ORIG-GUID: A34db5mh38_I38gXGC17WSJr0GFNsRWz
X-Proofpoint-GUID: A34db5mh38_I38gXGC17WSJr0GFNsRWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250085
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

On Mon, May 25, 2026 at 07:06:37AM +0200, Greg KH wrote:
> On Mon, May 25, 2026 at 11:30:43AM +0800, Jianping Li wrote:
> > 
> > On 5/22/2026 3:03 PM, Greg KH wrote:
> > > On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
> > > > On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
> > > > > On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
> > > > > > From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
> > > > > > 
> > > > > > fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
> > > > > > getting removed from the list after it is unmapped from DSP. This can
> > > > > > create potential race conditions if any other thread removes the entry
> > > > > > from list while unmap operation is ongoing. Remove the entry before
> > > > > How can it remove the entry from the list?
> > > > Multiple threads sharing the same file descriptor may invoke unmap concurrently.
> > > multiple threads sharing the same file descriptor is a horrible
> > > userspace bug.  If you do that, you get what you deserve :)
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > I agree that concurrent unmap on the same buffer from multiple threads
> > is a userspace bug.
> > 
> > However, the fastrpc driver is exposed via ioctl, and any userspace
> > (including any random apk) can map directly and then call multiple unmap.
> 
> So there is no userspace selinux permissions settings on the fasterpc
> device node at all?
> 
> > This patch is not intended to support incorrect userspace usage,
> > but to ensure that the driver remains robust against invalid or
> > racy inputs.
> 
> Isn't control to this device an "admin only" thing?

No, it's being used by normal user apps. Also, there are systems without
SELinux being enabled / used.

> 
> thanks,
> 
> greg k-h

-- 
With best wishes
Dmitry
