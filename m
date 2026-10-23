Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A6606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=moYOHMFI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U0xrvcU1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0656A10E71F;
	Fri, 23 Oct 2026 23:37:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1ACE10E71F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:36:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvOH8886330
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Mgo2dnohmbku8+6gd0EG9FENz+puwwm3rQ80la31iuE=; b=moYOHMFI/3MRcJDz
 ZA8WnN7yEfSkWsyYp8v9+QFucDkTCQC8SKcTMqg6RzdAtSjs3QzyZzQWJj0B/Ck0
 RUVQ95Vua/zwF3kcxhebMt86PgFMZy42QbaGG1wXhzJI9u5QVSOEYPxzcdwRGL5g
 v8e/Cwpg5r/HTWQirguGNfljG9bsB9eUsY068Ty7mtfFWZ0WCbFD0USBCprfm2Cv
 tP4D5MY2tkdIdOtYAMZUXZa5Di76LOUTGCgvyc8GSjD9Fx7Ln0TieTpXRURC96qg
 +UKV4UvxmqsF+PWNhqI2HT9ElC6Wn/6oWhECs9FABEYmXr70LNHco9j/K0M4FKGi
 fs/lwA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw29r4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:36:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ecdc701a2so192775485a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792798612; x=1793403412;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mgo2dnohmbku8+6gd0EG9FENz+puwwm3rQ80la31iuE=;
 b=U0xrvcU1OO27gVYB2FFxTh/QdFqJe4+BBkxoBcOW+Jin0bYSp7wz+wBUgI2UHfKY0h
 oK7kueh7YL7VQDRxSLwqJJgA2tvztXUkxs4b3QGgbDiP6D4H4z0NBlqQTruaNbUVpFLp
 AxzISxO8CiWPLMU9p5px6g4LkFEjckEP+Mj/GF99KzH1aEjc+a8FhA2RO/PvXDpypk4y
 OEDZfdtRdva4SeZib4PrQJq/KnobEEoABh45O29gX9O24xxmgHwDK4UugGfcnJkN83F9
 ua2/QZO3hg2fWSev7XI5wkSo/WqL5CY7VFfDGwY7uOl5j1frvNt8KDvarXQiE68aZ3gg
 0jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792798612; x=1793403412;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mgo2dnohmbku8+6gd0EG9FENz+puwwm3rQ80la31iuE=;
 b=d6FYYUFqX1SI83McLZAyRn7k0iNyA4Zt5ddnRg8ZdtTzo/GxfFvJJY1OvSI7r73QVX
 Q10p8GkKkQ2DyEykBVaBONHnNJ+1Bpl0AVP3aYwSRRzojAhM5I4ah97fFiZamBDjB9mK
 VKXiVrWmTx2R3MY0GUV3Vd2ZieTlAnBTsyrBRzKnCMaLodcbDsxez7N+rmEL7XAzE/sX
 aCHtL6+L5Zejt2sKxLVkuAOET6mzyskrOEQ0RCJdploZcDgfLlLDeJbhMgC+Wa/9n+j0
 BNaFFfQgUyFcmJi7i6Sva+r+runVaAqVeMb06s3KHoUB9OovKtyqDcjk92iS+Eq6taDz
 Q8pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1Ps1jUXB0QYLuJKAlbrm/2O4ivCYkBiRTp/Dos6x7kspAEvSawWQyiuE+RFdx2ODGQAK9q+xlKFU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLjW5Pf38z/JLmDQJOllpe0Mgdhl1GNOBSVV5G+uzUcf9gVj5kp
 BSwAmJHAY9TEwQacU1IjU1YHn1Tynkk8v4Mh4NNEJ0nDK4YNQiR1LnBEktm4IXw7PxfdYA6+zuK
 nGI9MI/Up8x1VQwgGEovYBxQv9xtJ3XDWN+7T3cYwVsgcFwxeSfJ51ILPcUN92WrV3OPjvxk=
X-Gm-Gg: AYBFou13anme0fJOsK71VHWKfdKZDkI5uVJ6hdLs3nBvyGJldm6PZyP+qfD7wjwpgNL
 zLkJlEGZ+WykJeswx4d2mr3ZzmLqbfjWJXVqCApBMlNe70rz0YqQVTm67HKPrkaZJv4NvWMmHqT
 Rgx7n7lFnXa27Ah9svtMXCC8DJyHRUPmEYSFF+wm33xZdYZ2vIV8dYRib6sQfb4xUlBYAVlyGr4
 ReIC+kJtR4GzylR6e5QEUJghHTxrVlxezvJKF/TD0RNRPx4Uxk9Eg+kh8NkaEe7SV+w9I6UGMbj
 SbC9gzNCnDnvKjwFbPGBCOc0tyrNVaunHmKF80WPVowEI4iXyGywo528Un5xut1z/bJcpnNwOpI
 LvwXv49htnYl3GRImCY/Il1Th1MZB9Bxe2Y4vJilowpegzZh2EeYqI0UYWJvHYAOPLiy9l5xf58
 iDzc8LrzMmunsk
X-Received: by 2002:a05:620a:370b:b0:93b:eb9a:ca47 with SMTP id
 af79cd13be357-940ef938f5fmr84042785a.31.1792798611910; 
 Fri, 23 Oct 2026 16:36:51 -0700 (PDT)
X-Received: by 2002:a05:620a:370b:b0:93b:eb9a:ca47 with SMTP id
 af79cd13be357-940ef938f5fmr84041285a.31.1792798611386; 
 Fri, 23 Oct 2026 16:36:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a6b051sm67463e87.14.2026.10.23.16.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:36:49 -0700 (PDT)
Date: Sat, 24 Oct 2026 02:36:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
Message-ID: <o2zmplbtmoueumw3iqejfsdmucp5f66woa5hmw3vodbe66reab@syn2ashugzyg>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
 <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
 <t5gu6ciwmxdb2jghc44gtixdsbedkgy4yzke5sgawjrr2h362u@ahvhh3yfe6lx>
 <wtun2cfukyzxlsfiz2izsejd33k4jpapwqa3uqih5drcsrkff5@e6llkke5dayw>
 <1f6db59c-b7a9-41a1-8022-6713365fa09e@gmail.com>
 <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcb86c33-1893-47bb-80eb-20acd65f3805@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: ezajxcQE0JnS9PgenxB3IGBXat6YFRVr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MyBTYWx0ZWRfXwnVzsHzykao9
 M1jXHcn51pztstxt+5fwXFQ2gddUtraix7+tkP+31zpoIlhuYoaxoOe+C/uew0lCSzbBdtkP0qn
 zSAqzr7V5xOQtwMIgM62NqUP5ZZbYgA=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adbef95 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=9jRdOu3wAAAA:8 a=s7fkfekX88plzggl2-cA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: ezajxcQE0JnS9PgenxB3IGBXat6YFRVr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MyBTYWx0ZWRfX1kyUg9SdMGLW
 Dn77qEv+vRe9QMIDMMpl2SJ/3oEsXGzNwEomWPRSNKLtrN2cTYt78x30PXDrefgQA6T853v7tvw
 DePXj4zgPurB5z4zCHkTiiVA4A773lFKfuiLI+tBpl6y2VSwSbtW/SxFHxqktRqbvpFH2WE2PCi
 amSD55rZiDsZtepTWCZUMWb3f3GWb56TnU4INBcIntSOaZDA/D9TsgKPSMVlf1uPzTfgkOmQ31c
 3mHeQjLLYq8ZgwYooh+qN+tumZy1gt/Xr97lCsM+XdcBRrlpmK62M4vy1TQqGhqGVTb+gQ+Tgw/
 wza+81/Df1XhoYWQax27JERlRWM/uEJvgSgW9ndrVz/j8ZpUZigORdzD+VJ+5FD6sL/0obdmya9
 ag8La/qmHV4UBC+sAY6GYByBqY1kNJG4R0zmckDy2R0YFHuc4KsCPrgSgHeKFOtLbxe1DxeJ/J6
 MKEwJ/6uDd4E5mzQKsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230093
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 03:16:27AM +0530, Akhil P Oommen wrote:
> 
> 
> On 10/22/2026 6:24 PM, Anna Maniscalco wrote:
> > On 7/9/26 9:39 PM, Dmitry Baryshkov wrote:
> >> On Thu, Jul 09, 2026 at 05:54:23PM +0300, Dmitry Baryshkov wrote:
> >>> On Thu, Jul 09, 2026 at 07:12:39PM +0530, Akhil P Oommen wrote:
> >>>> On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
> >>>>> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
> >>>>>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
> >>>>>>>> In order to associate the SID used by LPAC to it's own domain and
> >>>>>>>> context bank we need a separate node on the DTS.
> >>>>>>> Can we use iommu-map instead of adding a new device using the same
> >>>>>>> addresses? You provide zero explanations, but it seems like you are
> >>>>>>> trying to separate a part of the GPU into a separate device, but it's
> >>>>>>> unnecessary.
> >>>>>> What I was trying to say is that we need to map sid0 and sid1 to different
> >>>>>> context banks.
> >>>>>>
> >>>>>>  From what I recall, so long as we use the same dt node, the iommu drivert
> >>>>>> provides no way of doing this.
> >>>>>>
> >>>>>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
> >>>>>> and secure.
> >>>>>>
> >>>>>> The address on the lpac device doesn't really matter. I have very limted
> >>>>>> knowledge of DTSs but I think we could just leave it out altogether?
> >>>>> I think, you were poined to the Glymur Iris patches. Another option is
> >>>>> the QDA driver being submitted too. Both ot them use iommu-map to
> >>>>> describe the same usecase - a set of SIDs which are used by the device
> >>>>> but which should not be a part of the defaut set. With it in place you
> >>>>> don't need to have separate qcom,lpac devices, no additional properties,
> >>>>> etc.
> >>>>>
> >>>>> I'd recommend following the same approach.
> >>>> iiuc, the conclusion in this recent thread is to use child nodes for a
> >>>> similar case:
> >>>> https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/
> >>> Let me check internally.
> >> After a brief discussion: it can be either, depending on what suites
> >> better (and if you can persuade DMA / IOMMU maintainers to let one extra
> >> bus or not).
> >>
> > One thing sashiko is pointing out is that new dt should work with hold kernel so, in general moving sid1 from there would break it since old kernels don't know how to handle them separately.

The rule is the opposite: new kernels must continue to work with the old
DTs. If the new DT breaks with the older kernel, just specify it in the
cover letter so that Bjorn doesn't merge DT changes before the driver
changes find the way into his tree.

> > 
> 
> + Bjorn/Konrad
> 
> Not sure how strict is the requirement for compatibility with older kernel version. An
> option in your case could be just do an override in the board dts file of the
> Steam Frame.

Anyway, would it be a problem? Does GPU normally use SID 1? Or is it
only used by the LPAC?

> 
> -Akhil.
> 
> > Not sure how to address this.
> > 
> > Best regards,
> 

-- 
With best wishes
Dmitry
