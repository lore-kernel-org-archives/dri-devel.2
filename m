Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC9810F2870
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA7010EEAA;
	Fri, 27 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HqAFcWcq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kXY0XcnK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EA110EEA3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:13 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2RZ11774499
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cq5dhSeGSRTlxYc8fLxHZcCtB0aiTwv7Zw2omJFDJf0=; b=HqAFcWcqS9cnccCR
 u+vY8xc38PRSmS5CQ4ssU6XVaQhsfGXR+1Wb50v3GGkPYjqYAXGtNvyebaTIP2Vk
 BbEEeOOJZwFS5tEzHWmIPQBiA0YMutfqAnoCO3lSt9RpaXFI4mql4imk1btn6PQw
 7jwhb/M+25ADRi0YhLGJ27yOdBi3lzshKMslDOr384Ju9hs49J4rAgM5CRf1L64x
 JL3laCzXCUJkMLTmIQ7Z8r7azzrOo1WMknqnMXUJa05V/VKJNlN0sy6gxP7/P/ru
 Kd9Mu3vyL4mAPexfK4UAyvaRfsHL1j/hEnWx4AtMCo5e1EwKBpZp/UXcBR2+1N3u
 PY9vyQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5vvv8rea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b220c72bbso86262431cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640892; x=1775245692;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cq5dhSeGSRTlxYc8fLxHZcCtB0aiTwv7Zw2omJFDJf0=;
 b=kXY0XcnKCxwAXO1mrcxIBYw6M9y7UbeKRd753dx4GT28z5V3CyUwtLq0N87T44nCyr
 eIepVlbjrblDsZDq26ib1IEWPmzs1+w4UpfaqgTppZKBUgg6gxksFsVhHzAg8/UbRdkL
 QQOJ8TM6kbfmH1kFhtnVoi0Bgjo92CZE6stziAiBaTi0A6FTFw1OZepqMfujFe+Edxzk
 yf76Xl6HCwmgynMZdKHt8U7WDCL0EeGE0xZmjsHjWqaoMP3S1G3dpuC5wiXpGy8EPewd
 rulxrk+T7WBfa8rM1f9NwdlrdpKn6cLEBN29ymc3VZKaB+Z8ajKlDg7u+1i11jdjXFaU
 Mgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640892; x=1775245692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cq5dhSeGSRTlxYc8fLxHZcCtB0aiTwv7Zw2omJFDJf0=;
 b=LiLxjAFc+WjstbLEepN3LRO1pfPgPO1KixOVQEU1OZWMkZ1dVVP232AlVks00Z+ype
 RPLTHYpv8fSawoDU5eoHKr0YcefNdQ8qCTT0jlSrq4+OyQla506EvT6+jchRWxDXxMLS
 bImR1Z1sbCAYYDQJUNR//KKtAb7E1jSKh0tKSDIa1GwtZYSkehIc1aZUMxHo5sOXVtGC
 OH7oX8LtPaK5RUgHl0ipXpCtU9J5dYpRle8BtDVJYDyXW9PhIPHCh00FyKgeRJ7dlO7R
 STpHp8IqzzK2k9AjLbzUHGnUO6+YVx+g9BV8zdoX9qhXOJ9qJCY93MjBdoj7ZUu8vP+h
 2Ylw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkP+raPTfRPq5JnG0q/NgpXB7y5HJLv3f8lGwN5+4YHvO2YEQK8FIapRk7mDGHMk2bChs7m9vwwxA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWnGd2p0XtXkC0BeoUVLohFmMjM1uzmKyFE0+YMSUOOZuvdI5l
 PzoRfrBHZubcrIuB6Ys6RmAiuUNDqDfim4MqykUnf8eoOFirT1sVBYbyO+tBf1dKkZgRMNxuSOc
 ccXoz/wynvx+dGLAn7KlK/P2hPkVblqcUG6+QLcxUmH18saSV92dlZsAeS3+CdMQSBZgz1Ag=
X-Gm-Gg: ATEYQzzFH4aqKRs0Yx2NQ29wS67Ieu7Vh7is6b8TH12Qcg6LUBtyh12m/8jt5EeA+Jx
 y4A9grVwAcruuzuA10tG3FA/KQK8H5cyNdZe5BuHrchTyvkkZdJiDKH/cv3cUeVpOUv1X/IZhEi
 19elgyZvri6uOrFeu2dx7yiFsiJtZK9i5y6RrY7URHYm0RZkplF45Yb819xJhpDrHgtbXXOxBFo
 0nWCI31Q88GRL6VtOHP0hkd7f/dkIvW3BmUJXqy3unlLtZYSvBruL+h5HDLi3ADNd6cFzyZwzNU
 7bcmXTsDrDjgRpaqlB+JoTZCvdzgNgvg7eQxiX/Ez/ZQhxhY1Yq9T0fOD1Pmk5bBcP2ytE1jA6V
 UMgoSNbqoFgsZAf4mKTPL9AZ07XjhBDTIOXia7lDeKnCBfgMqzlQ3X1AzFApCIDk9i4+JWaXgQY
 zf/4AucOs9c8PhnUDn6ELEKK6fLjOVMMdz
X-Received: by 2002:a05:622a:514c:b0:509:a9b:8a6f with SMTP id
 d75a77b69052e-50ba391e18amr55909441cf.56.1774640892144; 
 Fri, 27 Mar 2026 12:48:12 -0700 (PDT)
X-Received: by 2002:a05:622a:514c:b0:509:a9b:8a6f with SMTP id
 d75a77b69052e-50ba391e18amr55909091cf.56.1774640891740; 
 Fri, 27 Mar 2026 12:48:11 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] drm/msm/mdss: Add a TODO for better managing the MDSS
 clock power state
Date: Fri, 27 Mar 2026 21:47:47 +0200
Message-ID: <177463970815.3488980.850210341944130535.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310-topic-mdss_power_todo-v1-1-59457b8b7486@oss.qualcomm.com>
References: <20260310-topic-mdss_power_todo-v1-1-59457b8b7486@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9w9oJqU0TsmcDos1zggphBjxC_Ui6kp1
X-Proofpoint-GUID: 9w9oJqU0TsmcDos1zggphBjxC_Ui6kp1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX4txfoYuvWaMa
 Wg07/XpOC+ko4zdOuzdL0Sbi2Nb+u32sgfOF0SmraC3nhRe7dOV5QgPpNlCaxd2O32fQZ5nh38Z
 YFpWXcVYQly6c2grkyL0dcI3zfYziIPBXHpDS0cDndpqZ+VanwYrfdukPLrxwqhWlGH1zEfIq8l
 aKHtHMaTZox24TMUrA4Bs1F+5lIFKiZ0+bL/h8yA8hguYO54mdpQ80bjrb6tjM+yC4G23+lr6+s
 yMrQXDQ/ZG1qMhJyTasIs85ie8DChJ5Db12mmJZLVR4Bx8nzjIwvq5emxng5XGYGGDXl5cD+Lbj
 9iHHD+9J/yII3eyTZAAvzpZXQqFQlmDJSZTjOik0QNkPbwgVv3z9PyuM0nestQjCMclohuxYDNT
 T3Mc/byxOqHSjbuEoujW9HP3S5ERzmpmnawD310XWmDNP5LCdOzSuMEMfVPpa6fE/gcrAfXASSk
 V6NqoQSiSXljwrO+1RQ==
X-Authority-Analysis: v=2.4 cv=PL0COPqC c=1 sm=1 tr=0 ts=69c6defc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=pDP1kiaYlr0JOoOXNPcA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270138
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

On Tue, 10 Mar 2026 14:20:25 +0100, Konrad Dybcio wrote:
> There's a small window where the MDP clock could be set to a high rate
> (say, from the bootloader) without a corresponding RPM(H)PD vote to
> back it up. This is normally not an issue, but could be, if rmmod fails
> to shut down the display driver cleanly, and the module is inserted
> again, or when the providers' .sync_state has timed out.
> 
> Mark a TODO to fix it one day. Linking the relevant discussion below.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/mdss: Add a TODO for better managing the MDSS clock power state
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d19faa0dcc6a

Best regards,
-- 
With best wishes
Dmitry


