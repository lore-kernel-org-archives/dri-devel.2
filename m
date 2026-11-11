Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F8606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fH9+ikMx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IqMMeodp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F75010FBE6;
	Wed, 11 Nov 2026 15:52:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D6910FBC6
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:52:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABFPODo014772
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=V93kB7u05RsWp0bMsBHWnhdz
 wP8D9erQ42L3lDrjbOo=; b=fH9+ikMx82geJa3TucKjpmFU7n8JCGIyKlR0zHX5
 VqZ6kDY9HtMQIt4WvJc9rqbXVG0X0h2fZezpU8vwLoYUtCGJGBSmz5Dtly/pHuEa
 InOCM0hwq7g2RaG8aMwKk1yFunRudlRVNy/LapKZ+m8q5WS88xX6hhVJF1sEUmHV
 0qNI7SpHEuwlWvRVz53b2H1MOvQfELWJ1kt/iDgMvyV4wiTTMndiH9p1HPfjNiSZ
 9SB1jkwO8c24Q2Y+NS65/4Z7Wo4ZiK8KHwB1Tqu1jUFpDISSBQsXrxLlgjDZtVFC
 UNSmYCRNUTn0QKDBT3xhxuFesHrv4q02zQs999Lz8zxIiQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymr4jj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:52:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2373e9b4so407344185a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794412321; x=1795017121;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V93kB7u05RsWp0bMsBHWnhdzwP8D9erQ42L3lDrjbOo=;
 b=IqMMeodp66bPVAqnvTGCrlWLq6r70pzxroGIoV9BjIzZgvd//cEH8auirDGTELT/Kb
 h611zX+VxLYEsq/0QLZUvaxMP1ej7c2NI9edr6YpKfHL1L9h7/4A7G9fpoFfczcMnFyB
 6BpPq8U5azSW8nqahJOc1bn18nRqXyXi8yG9PDYOFPdo2Wv2+JKGsCRzj/baT8demiwI
 9j53hz5x33QEMfH7wzmPi01n1OCIfbpffSBg3aT6Wmx8Zlj9s7R9Pfiz28WYn81Ax5wK
 7vhZnSyFJC/Cf4i/ETo4E7JdFW/CWrI/BuBQycP/2PHXJlzrQwtuy7mcPVHcqjaeJR+5
 vVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794412321; x=1795017121;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V93kB7u05RsWp0bMsBHWnhdzwP8D9erQ42L3lDrjbOo=;
 b=WUbBbXhBI4wsbbSjSprDC1nc9tJXOJ0Mzp2J/810YOSO1PFM91ZDO/TXtwfgjM6aS1
 O3kPn7l/vYjlyjocCbHGoIV3uHNZtEBGLilzi9QYsP1Q9Ahi7ODjoGQBlUCLtyNOhSdc
 o3CEJVSzCLYAUmvMLwG+58dF67BtNrKoLUJqTwAjVyw7/ZhK1YiBVJZ81eutQ2nSCPlU
 9SwSL3kk/3MeMIvodW92unxkPW2GWMq7f4RbOhatB1cjrSanASgRbhfl4aupw5bZ046A
 Hx/US+j7N8zFWA+6hPs+lDtPBJUU7MnM3PK4lur1y+AYsKt4hTDZRvr66n+tzcOJIwcZ
 7enw==
X-Gm-Message-State: APuU4Z+2li5BP1KbrM7FrCLT3NBd12ZZMOdChnk48/HncJ7jyP3uH9wd
 e5h+xICGhTM7O/1+YRajZOArRllGRbQ8VLa+SQi+XtLOs0I2KwsHm9d9OAred27t4bIN8S3sriP
 aYCVXcovJjj9wcvBOVywEzE+oPSUTPOGRcJNCZzLHWpM+hYPv7lXtQhOeBCeecheHu3XcZso=
X-Gm-Gg: AYBFou0DIy2ohK7jjrpnQyj+FOuWcOkOTpTF/cQYN/WVSLCnb8ltnfEl0e9g1bKjjG8
 W8Kviz4I0CgfDNitPTveeZIOqLfLSTEUbryBoOt59e6DXgjo3A+H3U1qjz1o9G37Ze0Zi/OqAp7
 un0a0cMfQqNrOmtV2WHdUzz1dN3AC6sWh1auwoRVyfkDwoopKDpN5JZyZLHIr7juhCFW1Ec7AEV
 Fw0Yy8+D2nT++KShFe1buRUJEb0641R9F3sbiMKApElhtrLFXOF4yEFAh5Vj4ElbdlQjLQicPa1
 h2iyWtjOYCGtz5REbRR74HMEGs1L+kE5mCm3rOAbsctfmMkETBTLD3hehOI+RlseRodK4ytpJnE
 ZQ8hKFI780CCx8AE/FoTvEgZ9jcajOxVL/IP4WHr9eVTvTLJRC1NCHqWGXUJEJGQkzdmPY3CTCb
 b8bxZ0aQrqVw90Z9iqS9rUgJHWht0On7QqfjWIK3higtHNzYRQBubER1GcQeYDyA==
X-Received: by 2002:a05:620a:a01b:b0:948:d833:1bee with SMTP id
 af79cd13be357-948d83321camr201207985a.3.1794412321462; 
 Wed, 11 Nov 2026 07:52:01 -0800 (PST)
X-Received: by 2002:a05:620a:a01b:b0:948:d833:1bee with SMTP id
 af79cd13be357-948d83321camr201199685a.3.1794412320217; 
 Wed, 11 Nov 2026 07:52:00 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092293b0sm11950441fa.17.2026.11.11.07.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:51:58 -0800 (PST)
Date: Wed, 11 Nov 2026 17:51:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/gem: Deal with partial mmap's in fault path
Message-ID: <ie2suz67iwxidcggliefmuyi64rxhbslk4to34cb47ctd7jmw4@a5ran3vouptl>
References: <20261106190317.17904-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106190317.17904-1-robin.clark@oss.qualcomm.com>
X-Proofpoint-GUID: 2m3OKydAnboi3iidIn1JVURdt2LeXIyF
X-Proofpoint-ORIG-GUID: 2m3OKydAnboi3iidIn1JVURdt2LeXIyF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2MyBTYWx0ZWRfX99wKKWBF+tE7
 YjI/1gQLms5wq4yLhcO/971D3eCw3tCKRMuLFgSixH3t0ao1nLuyET/UIRC9YUYPAZTHv4uXFmL
 431tdxcfJVU0GxTS3fwsG59yUyeHwOvpOKKX04cMka1yKbtXhzJn6l7DR901FUOah+kbD7nzGHO
 PvK4y/68MQeU4ToiSzWTOLO1iIQWb9bLQJGmggARpvHDOP+4OgNtoDMAig4Bm/liX/c1sf6DqIf
 PaFuYGqWp/4+F/FFV/NkqnfVGHJvd91P9ujk/pCIknv1TlLRuBmFe5zodOzq4DMXN0sFQqDAX4M
 wwj4GN79okj1m1QsCHibaPWAkapa+Q4ILqUF4MCOUmzZ3Jg1flFnC7vSuJoazeZi/0XXGVnDl6T
 ZdGYPDdeirouqVdILRQPnwaUCEn0NUoIAn1p56hAtZFqSJkpekyENKwVmqmZ4RAJ869D/tblvqj
 IWOK460dEoKwQ5QB62w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2MyBTYWx0ZWRfXxqip8WwkMYUw
 O410mp0Tw0UDBLK4S3gWYI0dXowy+PLnDztCgSzUz0InglHc4opfkq5eoOS6kyFd+bd/q5PMqyE
 ev67ypx/BYV3ii+AbcNjl43M2V9VIKY=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af48f22 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=cM-CtGeE6IhlOtB9VQsA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110063
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

On Fri, Nov 06, 2026 at 11:03:17AM -0800, Rob Clark wrote:
> Historically we ignored pgoff, as it was a "fake" offset that simply
> served to map back to the gem handle.  Mmaping a partial obj was dis-
> allowed.
> 
> But we can instead just subtract off the fake offset.
> 
> drm_gem_mmap() still expects an exact match on pgoff, so unless we use
> our own path for that, like some other drivers, we don't fully support
> partial mmap.  But this at least makes things more robust if userspace
> does funny things like partal unmap.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
