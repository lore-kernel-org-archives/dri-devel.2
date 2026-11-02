Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A49606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A0npo413;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hkGQRq9O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C794910ECB6;
	Mon,  2 Nov 2026 10:29:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5067010ECB0
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:28:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29AO0F3086537
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 10:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=GWPR9dxJ+6mYEfqzZ0xvkf12
 jtHOjAmnZXogzpguUXQ=; b=A0npo413P0imsetLspBjs262CH8BXVYjcjpv4jk3
 Dg8z3cG02zDKBgSC/kTP1WukPF9rJwzzVP5q0lGoGHPV1qit9zluSZkg3IhlVqSk
 DM+qrXx9XX418xuZsaGUxf1tvpB+E+jDoVL/2AdOeWjwentbj+xRJtajk/jdFZBD
 Es/FJwn7cdJf0SlOR7xuqrtUNuX/T9FM+6deYmjK6VyQCBi7MHzyPprP5UZVUp8K
 FINF5rjZ300Xy+O20HgvCDAcoWhtZpf/VguhYL6yEGJO+zUsvkCxw0w11MPXyNhe
 dr5AAHvPbJBRlL2iK46bOVFw/ylMjxaWHYHCjOilN8O4Hg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka61bjv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 10:28:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91becce058aso61054946d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793615328; x=1794220128;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GWPR9dxJ+6mYEfqzZ0xvkf12jtHOjAmnZXogzpguUXQ=;
 b=hkGQRq9OYVgFggKE1o6RE7rOMqbgkyPIi1pKvAG1Mh3pI3WLX8UXzSeV65zIEeBxac
 /7gZFYZcU2GfJ0bz1Kh6ocQWN4EtZ2baZ7Rzg5exIy/2UKs8PqJAo12z0DQlqfTgtQwh
 LODVRN9MmsTrBjy6cY0r5u/5HPawn3KpREMSf3DCvJ2b1VMvIZiScIuOXDkCokR+ZUyp
 0gvH8Ab/YYyqNignPJPDykt+2lZ16egbyn9GmRkL8B6bx5lW4+zFj5k7seA9N5rzx2rf
 xqbBJ98TOzx1HjZivxZIwv6Q8S8BHxfL1bRbnYmdE4gH1FeSKwa3RqCzi1sXciqPxepd
 fw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615328; x=1794220128;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GWPR9dxJ+6mYEfqzZ0xvkf12jtHOjAmnZXogzpguUXQ=;
 b=iCerzT53cQUO7u8r4GdwAidxBFg45GIGxn+BAM4qcy53bE/wlaqN5Ly7gaDuMoFh16
 yX9abWh0DTPz/9egFgO/h7wLdZQtZ06tAG2HH8ODM5fPV1ZldNTF6bZgq8da1pkIGVVv
 qVEyUjMmpM8Uj9g3/XOfUfMcE5dioE/n7IgI5EfUNJ87NCH+qlu9TF+UXv6pdt9gloQ+
 dIwJZKDCZB2zA/KQBwgZNimTSh6DM61FyxCTNKJ6ew6g1xuLPlcbgxv/mT1TgrwKcxtT
 EVHNCbj0n0mOF9S/3IRhFsNOTwi8X2PeoWbqe4tuDxi+bA43hJN0GDa3hATf31jeA9v8
 FAkg==
X-Gm-Message-State: AFq9FYLg1sfbYiqnLVuoBFxyhmRBHwWTFNxEIdofoDRZjfOrBYYoR5X0
 oKpmlKPkDUCjjGn9I7ADqSoGCPBMLoelZfQocn7DiPmPIytOixJkbYhhchXXTzAqEpTP0khvpGj
 l8YqoLBiGY9Gs6x6CuI+RwJKevZAl56E1vzzlKTzSV3cMPmMA80FFyak6oMsENbI5kCwahLQ=
X-Gm-Gg: AYBFou0fGedJnGXRBNf+P4aIddaquJ7LBZqldsxDxzBREQBbNuEVhYSNQPB65vG8Tj9
 NhCUZOk6djA7E//akOpKGgVmbXWF5DilUrLgSpNWSCq9p7gExbETXw9eZvq7yFaIaiXM41xE5mX
 xwFIhdhJTv4go77KC7n3i6PjLE6IEzY4FCg3Zx9Db+MNUZAS7FTacGVvvAvCCTwOJJ9WbylGU7o
 Yw3mD8sBbh1q9+gD1qsJkazgwk2WFTnmXiXTIP4sW1KI02BxLITDsYRwP9fddC5t88iYZrQfFe6
 PpEmEg84NvlxQBPxZI8zQBjLwyWvRGQ9LoWajkeajGdDhxZwb8FwhkNAOCmhCkTEtFO30eXkU+n
 AnRpRCBZLXOW1TupVhrchLnII6ZkIAi1WjDAfwdzoJAFcluZx+dZSuBK65c7f3XlC7JlR0q73On
 9JlxtSVRgiy1S5J4/kc73LrWevA9sYp0xVEjvw51pfxMlNdhpe+4m0f/mCSJRx
X-Received: by 2002:a05:620a:2984:b0:93f:2e7e:c818 with SMTP id
 af79cd13be357-94421799c57mr1645332385a.59.1793615327722; 
 Mon, 02 Nov 2026 02:28:47 -0800 (PST)
X-Received: by 2002:a05:620a:2984:b0:93f:2e7e:c818 with SMTP id
 af79cd13be357-94421799c57mr1645329685a.59.1793615327296; 
 Mon, 02 Nov 2026 02:28:47 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe072194csm1649332e87.15.2026.11.02.02.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:28:42 -0800 (PST)
Date: Mon, 2 Nov 2026 12:28:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/msm/gem: Disallow nr_bos for VM_BIND contexts
Message-ID: <pa5mluujqthv2ajikpoejheure4vswtbsu5jry52ek6k3myikr@heh6mx6y2gnt>
References: <20261101174911.25184-1-robin.clark@oss.qualcomm.com>
 <20261101174911.25184-3-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101174911.25184-3-robin.clark@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: KCWUNzmnvqsEnTmBBPukIKR3NOWsvzsz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX+EjzPjTi5lGy
 zo+saA/KBL0htXIBYVxScvZgPAC/c01lxe1l/J3NsC4Zu8bWcrv9j94sdzhpr/HT9gKDBhTw+Dd
 Bk9d2pZmfhC4E8lWou7lQjLrvl3897I=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae865e0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Mlro_P0Azzi2O7fenn4A:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX35b7mutM9ar3
 kL3YaXibqkTq5m+BgSUTncpytEPsZ8fBJ9wefTgU+DiHFrOXTKAcddKU2dQ18ZOQbFJIWLvtl4I
 sXFca0R+doHFgLSMXrkugQBlsAQM2SndL+6ZlOK6XnERO2dsNtvCKAZNdo4MfZmqIWeh+xY7qsr
 hTxvjSXKmtLISiJy57NFTzN93jnAF7YH4e7d7MqtfcDFLON+fK9dqiqidI4v0LO51NY0APdynyL
 iHWJkTa5tyVc59PKWaewJWjqVgxwjGQntg7wwAyZ1eN2d5HcMuYd8jl7xyj1qll0iE3bUPwjDj/
 XKk93pm42Bt0bLh293Ifo+g2TYrudOs/LmMDVZ+sQdRLeNn5pWEv7yvbXD70NbBU21SH2zrGvqr
 F606HPgenPXAFQczp01cJLhXXhl7ZRdTETfbkr6SuYwIIhSb95k7j9FK03CryF60v20IVLJgFzB
 r7TehZ/7oEbQs4zrz/Q==
X-Proofpoint-GUID: KCWUNzmnvqsEnTmBBPukIKR3NOWsvzsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020041
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

On Sun, Nov 01, 2026 at 09:49:10AM -0800, Rob Clark wrote:
> If using VM_BIND, it is invalid to attach BOs to a GEM_SUBMIT ioctl.
> Only the VM_BIND ioctl should be used for binding objects.
> 
> Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
