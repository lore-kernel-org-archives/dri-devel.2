Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F014ACD4F47
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 18:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE3910E29E;
	Sun, 17 May 2026 18:13:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T/luTTRS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bra5J6HE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0834A10E29E
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:13:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64GLGAk81200503
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1Qv0uuV8Ex5OvKUJ759UY79R
 1wNp48m7rDkw4nsWu9A=; b=T/luTTRSCy6ThZnqIMq4Yv9t7QpQoo3sMj3NuAPs
 RfWctSvaJ1iz8NPlEmCJxGfPfEaLbU/o6srfIXsRyDzyj/WfigponPfPIqjUJdia
 8QF0U4Go3zbojf6o5Jn1DgtCS33XiUZYfw/BqPIRxGRH+AJBdh2XCYluPWmsk86F
 TVpSGq/sBx2kRcUdD6r9jk9uKsC7k6Hw+ut6Xjbde5VS2NNbrETq38gtMpq1koWI
 IJZ0S+Wu0kgDCe7OcjRlAgv3vBu+PQX0eX/XPqvcPEVXo1zb7mzXhejUj4cJickR
 5vyVHRuVAmCRA5/v9kM9GTEQ+Fxd2iP2J8gOkhMVD/npaA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0g3apn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 18:13:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-514a182b90dso19727171cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779041621; x=1779646421;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Qv0uuV8Ex5OvKUJ759UY79R1wNp48m7rDkw4nsWu9A=;
 b=Bra5J6HE7uZnMs4PW15/1zdUAOhmYRG1ti/57wAoR2otwlwk7/Qroc7s9Tgb1If7DU
 I8jb7SXdB/Eud/Bne1xaHg5ctAiH1W9TGcDjKcE6ISZWCZ4Iy0JH5SCRnN/PzxfCJ1Og
 47zuqTFl3C034oS4pGz151018uz/FXwTP/0U15pvXX5AxI7lSWviNib9bqwMHXfR/s5f
 0UJNDuSFUTKDphdoU5xyfwrb6is8Ca39mJ39owjMYLTzBhfNoZcBWpzenjyEVrXwVCx3
 GIBdtODueP3qtgGgOSTJt0YQZ59CpREgft0oke90gtUuBQ5F4UxMGtHaI5Z0I1Ml6mxI
 Wzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779041621; x=1779646421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Qv0uuV8Ex5OvKUJ759UY79R1wNp48m7rDkw4nsWu9A=;
 b=koxlwF0ASOXhv/sTax/z5nek1ujLUsjtTAy/Ea5Xx9hdC8u1O+aZttRnlUX7Dst/L0
 NpTnaup9v+3xr6jr3jW1w3scWPitDq80r0tIaJAViY0bKJx1zUBE5fmqMxXux37Gp09Q
 ukMAGRZcX311WswxCQDLUibq1j7HiabnVW0lgkgkzQq9n95Tk3GThb196LRYF26nIgb/
 Vp8b/DmsdrK6tqjMN/rDIdTRjJgvpOM22p8faABCMrMaEn2dteRTEND8EMbkPpittyaT
 OZ8K4W25X7I/Lz6qlS00k6lXq3NBRWrQ97Hv3poPCMHVV+ypZgz262fWG1d/hT4yggl3
 5T/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nYJQG0Q4zCKdEHVfFfXr0lXejNrBrcWGcinZE3XPmnyaXXfPa+cazHI8scs5Fkzjtpbfg+BGW3M0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQioTWU1eLUpWSiAHiJ0bH5XX2o8WpHHyLtI/emDlgFidxqoR5
 wg7cd9Oyult4sU4eJnxQv3YPlUF+/hhFe53Y6K8exNGBzk4mfbTrjTTUXmzqqDO1yh8EKt3Azcp
 trxZnGpcbFYpFQdX9oiwWa5sHUMKMeuEXYbBfM5zYvw65ElpRv5dq6PnzWFrrvLUNQZF5iAk=
X-Gm-Gg: Acq92OE7oXiJDMNfunGeS4nKzI/vBQFCYxFZ3S7vLDNlLbi8cSghVjGS70m0Y8g8wCe
 L3C2l1KH8FiCM5sn9rdKRxDtrwQaJtLylID1I0gMaPPHE4R+KbDithTJCUd13Db3xbwBOYlkJBQ
 6ihQm/hvVkxHs3UsPIJ7gfK62P59i2o3JkM7mS+EL0nE+GMhT/SiWAl1RA4Qf+zaEf9DoDKKwsE
 KsrtiNJdq4+d/HdawWf3T30x0jn1LwbRC8zC1zUUtsOGpvG33sz/9Jvp96XUL0gBNol0vHU11aG
 k37cA5U4WC0p7LHbEIon+3rP9HNEiN0AKtrq3KWkxZKs1GSXqfJ7SWBRPZ18qvwTqvERtmZfoxb
 WIdGAn0ZoRgupr4HLc5jVu+68JvPOKETH8Ha7TVYb+gqkRTFnXVmsxnfKtHr8McSA1230fkaJFz
 c1D7dxfVLC8Ic6X1yOmPc3o1nlGYlRRkcr5dA=
X-Received: by 2002:ac8:5cc5:0:b0:50e:62ba:3ff7 with SMTP id
 d75a77b69052e-5165a075923mr178266981cf.26.1779041621524; 
 Sun, 17 May 2026 11:13:41 -0700 (PDT)
X-Received: by 2002:ac8:5cc5:0:b0:50e:62ba:3ff7 with SMTP id
 d75a77b69052e-5165a075923mr178266581cf.26.1779041621074; 
 Sun, 17 May 2026 11:13:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395882c41c1sm6557951fa.12.2026.05.17.11.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 11:13:39 -0700 (PDT)
Date: Sun, 17 May 2026 21:13:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Oli R <sigmatwojastara@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
 "open list:DRM DRIVER for Qualcomm display hardware"
 <linux-arm-msm@vger.kernel.org>, 
 "open list:DRM DRIVER for Qualcomm display hardware"
 <dri-devel@lists.freedesktop.org>, 
 "open list:DRM DRIVER for Qualcomm display hardware"
 <freedreno@lists.freedesktop.org>, 
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..."
 <linux-crypto@vger.kernel.org>, 
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] treewide: replace /usr/bin/python3 shebangs with env
 python3
Message-ID: <u7c5s7dtvzmqteqvrhr5p2a6wc7sdtmhfksw5344grs2gzgot5@n2ybljjcrju6>
References: <20260515180806.246914-1-sigmatwojastara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515180806.246914-1-sigmatwojastara@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5NyBTYWx0ZWRfX3I/vZCYATqBZ
 /Cazney00lgIcamYB9RrUk7fppbmHVWX9buw/TNswG0s1v6Ex7zpQUrWiXnQ5KmDg0g/yOxp9S9
 Tbu33aJ4wDrfKze3rKDonbQpgYK2lXWxbejMHsWvTPOYKA+I2Wb0lGcYgS7/MtK6Aj5jzrqa4+r
 1DcwiVUx8ZXHCIdhhFt8qBYE2qs3m2FFsAFruqkKtxwLsgbMs2PIk6F6bo1C/MK8isXm2KrDJ6O
 blKvmvJvOpepKYAyrIvSz58YA8Vd7TpLwyvzzYasXsCEYW+GQKBVsu3abw9KVsr/S1zWWN/bmLR
 9UkeFN1pekjyVYc6EUw6VVqJZz89+gl+dV145LkLoyHcTww4xwX557ys9crRrq60tdxMIMOoAXW
 WEcIMErVP9r9XJEGmMcMwiD/r4Vx9bdqCIMu/toBE+Rhmy37bJi5ei1qhtORoWyGL8e8xHvSkX3
 lEItvlQcyQyr03UcUvQ==
X-Authority-Analysis: v=2.4 cv=W7gIkxWk c=1 sm=1 tr=0 ts=6a0a0556 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Vby_bzTUFChIRH6wvO4A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: lmWgdTuEQqvupKLNaK4hHsGyX16G_01V
X-Proofpoint-ORIG-GUID: lmWgdTuEQqvupKLNaK4hHsGyX16G_01V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170197
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

On Fri, May 15, 2026 at 08:07:59PM +0200, Oli R wrote:
> Use /usr/bin/env python3 instead of hardcoded interpreter paths
> to improve portability across environments where python3 is not
> installed in /usr/bin.
> 
> No functional changes intended.
> 
> Signed-off-by: Oli R <sigmatwojastara@gmail.com>
> ---
>  drivers/gpu/drm/msm/registers/gen_header.py                     | 2 +-

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # drm/msm


>  scripts/macro_checker.py                                        | 2 +-
>  tools/crypto/ccp/dbc.py                                         | 2 +-
>  tools/crypto/ccp/dbc_cli.py                                     | 2 +-
>  tools/crypto/ccp/test_dbc.py                                    | 2 +-
>  tools/perf/tests/shell/lib/perf_json_output_lint.py             | 2 +-
>  .../selftests/devices/probe/test_discoverable_devices.py        | 2 +-
>  tools/testing/selftests/rseq/rseq-slice-hist.py                 | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

-- 
With best wishes
Dmitry
