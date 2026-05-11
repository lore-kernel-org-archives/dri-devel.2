Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D71CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 16:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E87210E540;
	Mon, 11 May 2026 16:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnHlNz2W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VXASPqng";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39A510E804
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 16:17:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BCNNpR774903
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 16:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=OzS0X7IM7l/lLVRxpSgo9g9Bn7AO8/fqwA1ioGWBXaA=; b=nn
 HlNz2WuTsHi/QIKhVv+AiJz76fhTf2cpw1j++qxOQN5lfrQoJCuLB2d1DRmwsm0f
 iLJoe07uzUQhM2D/72d61GlMT5V/tZ7Se5fDT2JX40C4xqY+FE71N3A8TvIrCFrO
 XjhdTeGviKH4J4UMgfeFkUC7MNORQIkla8hMl1SdOvL9i4+l5HX2lL82ZvLkFKKm
 j6hIg1cqhadiuQa+EFgUZ9SgQ1PZ33fqUq6yA5sVJ3/gGICM/ucQV5eH+P9WxJeU
 f8r3GTgGOQwix82NuxlntY06qDSvtnLaITWOHDyoog1bceZcSd4u+gD/w0xGcOVw
 /NfU84/OzUMVIirhGbIw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3a32j7rq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 16:17:02 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6961e8fa90bso8178589eaf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 09:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778516221; cv=none;
 d=google.com; s=arc-20240605;
 b=fFnEB8/wbP1Tu2YjzKyKpAvtdYNN+/4g9Clx5ltF4/foXS1xlPULkN+WYrwaC7qaAF
 dFTQTJE/VvjrEMKDgNmLH1m2q9ZorAwdRrVUjtVeG8lKbGe3gd5UBe4I/0NzUuhnQPHq
 qimfObNKK+d8EETe57RyzT1atdHqIVpzjOEy23JE5zneclKVCdLBMk5LuEzFs0x0Wkkq
 30RReUCtTOcxm5J+0mV1gDZ5AKD0D6PIIOjiNw7hP4poC7cKeGslPmuy22gZNId959wV
 IhbMyLyPH2VgogaV2f9EWvyKzk6WeQVSzlNzAEpeaEZMHSlkYnEmGqxMyDFmWhgUPcW1
 cbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=OzS0X7IM7l/lLVRxpSgo9g9Bn7AO8/fqwA1ioGWBXaA=;
 fh=1168xPvGi39hHFWGNgynU98tkvAxCPTMMCzOB5JtMCw=;
 b=DzY8lQc9zEkpQvKvuCSaF0HdE73qt8KOLgLaXBzEqo2LVAJwArdEQuUAKGEiIWgBeg
 ERUAAIHcC2XN4mwDwWfCz9WBmgM6j8eH5NaOZibFSF4c/7kMvsIeRTVFvJuI+cQPNe58
 fgTI8F58ZkgEOHT9A2Y0MVVHyI1fXYSfvY2gkmcKcnM5zQOxM8yDa1rhd9OSVx4jEzsk
 hIfoyXpJ2sasnAW8Evdhio3r1G+eEcNiTCQqgn9Fnbfqws730fcT9Xxx2boG0Br457VK
 GuAsPO7tYAVpoKZXS2vrCjs9Cn8o1Y0MgeP4rmTHrBOo3MTK5+tuTyefat7tueUHYCRF
 FqYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778516221; x=1779121021;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OzS0X7IM7l/lLVRxpSgo9g9Bn7AO8/fqwA1ioGWBXaA=;
 b=VXASPqngYHwT8AwexpbCDj77zkoECpGxXvBKfCS5bOCHmpEUx0by3jImaK2QcuXo8V
 FQ4O2oGaTKlqlGCMDk0612q9vplqeQlqOUXpvXdMwdkM1HD4lWbjJ1QsWvPL7XpiNSYY
 oa7SOxtZgyGAmvACNSMWPC5YszFys+tmwSknS9xgW/cKb/rNnPOEF5zPkB9kdpyNyWam
 a8eqVqDR8fib1g8nz6MOwVpTEz2ixEvylySP//Z4lCAHNFpW3dVHfEcRs//QgKgZb0OS
 Vn86rDqzYlGA1aCisaxTBkUyOM+5NI/m2SU1TNwp2zRY/dPZvR+9cnac4YhSTCgSHleW
 WaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778516221; x=1779121021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OzS0X7IM7l/lLVRxpSgo9g9Bn7AO8/fqwA1ioGWBXaA=;
 b=NVzSvgclJXSxQ4sO1QH+9dW/hdY8luEfa8PSZ5gvs2ivtKPQDikTMs3i0P7LYGCRHS
 Mc8zmIZukLdmLq9QToocWsl6jtRMBxEuPI4E/e9Hx3dGxKUE5OczAwFMQ59XAJHqLBsr
 b+U7hCWFWRoP4xHWeUcf5SJrgvvRX7PlvcdDkJ26jG+gc73gyF//n/gS4MnTzIm/5yOm
 WEaI3UHcB6QfwagQtIuATwDxVHX78stSi0YpttHdHEK9lvFLGggiJvPYEQD8ofBuytUa
 ZRi6XhwsGVWjGbSwcXpCevSIn/UL86bS/inEkpbvILc5baDGU7xWjpahD0c4MCKuXb7E
 aL0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9KA4dykDHzue0f3LjIVPkSJ667PWwycC+s50F57ql0IGFhHvTTH8DwR0adhF5Ls68iav8haclSv4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRLcIK4lNMPeizPRIHvpOVW34eg2Yh3cIyi4v3Pi6gjnZNxks1
 AjPdLDmsOBKtt+T5AKzwgKSoZqn2ZrPP1qDPF94iiETyI21dyKWIxlxmEo85ILnGsqX6yDvY6MJ
 I7xxoI3Dhh6c/B6fezcG5xiwit0Ta3ZwUkQVzUv8lz+SClq6dy6pEvIPE0eEJHtGMfpW3AGzvHf
 kOPR67EPbsGIQpSlU1a9yxkdLfUjF5c9l2SaNM128QG66iqQ==
X-Gm-Gg: Acq92OEFvF7KHX/DSczeejrJQ44gMw5OdN127BiZvHQUP2Grpv103zp+oi5SAOGoZRa
 R5wG/0O1wqGGAC2kaovO7f+/HK80gloE8huAK+c6oKrk/fPYyIcEjIKY7PZoBPiBJLnXJR51zC4
 4NYQw+lGYtBihf03H5S/C+YVbWgZQtNKw7l9RIBGV8FwJhm8VejyPZqdJFkdY3mRDNcZF/3x0Ir
 Ivc4j1S/mwo2JvjrscZZDMpsMm3EBkPtqRPEA==
X-Received: by 2002:a05:6820:180d:b0:696:64ab:cd9d with SMTP id
 006d021491bc7-69998c8fedbmr14053679eaf.12.1778516221384; 
 Mon, 11 May 2026 09:17:01 -0700 (PDT)
X-Received: by 2002:a05:6820:180d:b0:696:64ab:cd9d with SMTP id
 006d021491bc7-69998c8fedbmr14053617eaf.12.1778516220881; Mon, 11 May 2026
 09:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260508-panthor-shrinker-fixes-v2-0-39cdb7d577c9@collabora.com>
 <20260508-panthor-shrinker-fixes-v2-4-39cdb7d577c9@collabora.com>
 <CACSVV00NdUKe6-05U3g0q5X3tw4zmqO_s2gk-KZxQVykpydvAA@mail.gmail.com>
 <20260511174429.35afcdee@fedora>
In-Reply-To: <20260511174429.35afcdee@fedora>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 11 May 2026 09:16:49 -0700
X-Gm-Features: AVHnY4I40hrkxySZSpEMeonWzoJt3rA3BByl76Aatz-t8sb8-MR6pz1lZCD7E1Q
Message-ID: <CACSVV02HQ-ci8mHg4os7e-yaf51hdHyQ6cFa9tGOpc9=keL28Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/gem: Make the GEM LRU lock part of drm_device
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ya4OF2hrQ3Qjt1iAFo5XFn6UXkAc-hz7
X-Proofpoint-GUID: ya4OF2hrQ3Qjt1iAFo5XFn6UXkAc-hz7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NSBTYWx0ZWRfX/r3cWXoAd9b0
 KSrqF3ULVp3Wn89f06oZTmAPydvIRKfAnUxfP7/IAx/PWkh/JKA69hwrEWCQI1RmEJ5D7h1R8cN
 Q5gaGwpOm/RH757514oJp819ADUsyteECVD0ZYWMTqKKi4MUplummFSl4+8choSKflf3nuFnwSm
 2ZdJxxwcnmSw5Kc6LeUzxhQGLLle9X/vbIEBGaTKa8+vDYijozUV2dkG/BdTuF9L0xEAduvR8rw
 p1fytRTLiuSPvSF+CCaUPFoFjVkimu4FshUFLo6FwFUSwdPkACryXX7p7brGeUPKApMzNP3Yqnd
 kp1ybGTSrjpst8EoHx8J3Ph/3upXsIcudLNzD8PLw+XNNc4wqLaksgRvypNyGVGXdtVr9w1tQJZ
 o1U6zrGiJi9BEI5pptQvqEqCth4V5ooEymc2sKRTRNYsAZJ2QE5z0F5d/3GsEhnU+U6ZsChIe4a
 jHL/46CjkHCaAXP865w==
X-Authority-Analysis: v=2.4 cv=SLVykuvH c=1 sm=1 tr=0 ts=6a0200fe cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=X8FTkJh-O0bHBhosSCoA:9 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110175
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, May 11, 2026 at 8:44=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Mon, 11 May 2026 06:18:44 -0700
> Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> > On Fri, May 8, 2026 at 3:41=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > Recently, a few races have been discovered in the GEM LRU logic, all
> > > of them caused by the fact the LRU lock is accessed through
> > > gem->lru->lock, and that lock itself also protects changes to
> > > gem->lru, leading to situations where gem->lru needs to first be
> > > accessed without the lock held, to then get the lru to access the loc=
k
> > > through and finally take the lock and do the expected operation.
> > >
> > > Currently, the two drivers making use of this API declare device-wide
> > > locks, and there's no clue that we will ever have a driver that wants
> > > different pools of LRUs protected by different locks under the same
> > > drm_device. So we're better off moving this lock to drm_device and
> > > always locking it through obj->dev->gem_lru_mutex, or directly throug=
h
> > > dev->gem_lru_mutex.
> > >
> > > If anyone ever needs more fine-grained locking, this can be revisited
> > > to pass some drm_gem_lru_pool object represent the pool of LRUs under
> > > a specific lock, but for now, the per-device lock seems to be enough.
> > >
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
>
> If every one is happy with patch 4, I'm tempted to drop patch 1 and 3,
> since they are irrelevant if the locking is fixed the way it is in this
> patch. Question is, do we care about patch 2 being backported to stable
> kernels then?

Or backport patch 4?  It's a bit bigger, but mostly mechanical.. with
only issue being backporting across addition of panthor shrinker, I
guess?

BR,
-R
