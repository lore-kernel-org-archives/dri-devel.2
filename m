Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF60ACC6B19
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C97E310E8BE;
	Wed, 14 Oct 2026 06:09:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E6A10E8BE
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:08:52 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E1CcJ41591709
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CWZPHxPrDsIHSD3gEmzt1WwqRCC1BYYEjxCE29zFyDQ=; b=ChYSRtuvlrRI6sxx
 203OPQAiQtr+EOJZo9qU/otlwGp8JKra7v1d9PRWF7SOGjyJgkAsAElyMwWh+Mf6
 kjCkXR04oll7yDjfmiEFyRDZboO4+nnfF/yc1QhulLIjmYYVZBGGRvk9R3byYOn9
 iEsRnlhf8Rm4Qvn8zlFKIVPuDKQHv5IhK8Fhn0Rll1JHtOCNsQeTIfHrcXeJqxsb
 uKiEU+PXGOfPGMYekW/9/DaIsc00HgE4AWja3PYHA3ZZfiNGWjjfoGb7JB8KYbQW
 99NTRD1KBsxXDCyecpB9LZd5DIkdZwjA7wDuBLQNRtNQl+vBYz+IDhIL0CdUJyIz
 SvP/Ag==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s1tjn4q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:08:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso2752788a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791958131; x=1792562931;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CWZPHxPrDsIHSD3gEmzt1WwqRCC1BYYEjxCE29zFyDQ=;
 b=TDIBxAYB5KmoH3aDU3jnNftB+GjMeBnnVMu+HGFIWIdy+mvwPVtNcdNlQBbHFNShtb
 FEDqL3c7kvIR1NXjjEA7sUAXabyv3NGKd2DnCPqpgehCGqXp0mGhR0PXFi76iDNIdSfA
 DJZjd+D/Y648K4ZAGF0VNmeRdh+kdnb/lTb+IxCvklrSvs2ugheuANyTwf1lXbTL3WJN
 yCaLW+M27IGd6W4tYIaTz1NWjdqV5kDK5GqbNFlea89XxoxO9KYeXwOFCtfJi0G/r8Zs
 mdgbHgQfo66PYjiuGNV23JzLOvWg0R1DNkyKEArlYwR7Xfv2x2u4Kc7yYgA807er0Lv/
 840Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791958131; x=1792562931;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CWZPHxPrDsIHSD3gEmzt1WwqRCC1BYYEjxCE29zFyDQ=;
 b=DzIFFLwH5Tg2i3EuFsVvIcLZeB9KXZkuC5K5yWgnVsmymekuwH1YSuNyCQhpzjK+5F
 2qWsjd/GqBKeQKPfYs9dBcBYf7R1bQ5y9xuaDBBMeZqSIDumuom88YJEAQArT+k5146u
 ehBCzcDDy2OAuPNZGRx9zykZNTrfMfLD9QIO8yKIoHj6OZm9uxRlFWgUP24UHF8iDOSK
 6chX4sKUww1tZRBAzOfeb+sEPfwQon59n6UTCr/PbzFlqa7CEl13MrdlVpUKhoLeCrFt
 beBypDZ7iyPz4zriGSxHep7qAflH6l7nnNPhI/aegqbYLrct4rZPpaIATnHQFj6DgcyZ
 6RFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhx3Xxl8VrtGC7aYQZ2uljwgK99rr2qrfhAxjYMLd4ytmfwbwQQnLErckyUeCtbtF3jDhoc7RQCdw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIbWlISwHUsfXlcsOykYkh72mVQDw+ulifF3XfFJyPDsyrVGKD1
 7bjTcCBRIfmY/fcR/CzP/S09sN10hXZ51xaV/9goCfPR6d/zWumbFjfPSuokrWHorrUSxY40oJD
 94nseSot/mIxO+QJyMZ7i90P8KIoxhcAKoTffy6Bhfb7eeHR4NUydWvIH1VabSJpCc+GewQE=
X-Gm-Gg: AYBFou1t6LGYc8Mn3fAaJrNBskH0/HahlliajgRozPVV6Hr4sZA339AxwIavBGcsUhR
 wvFUR7FTdC1e2antVo8w6JDMLg7/9yTQR3beM7XNXQ9+3gd1wWtKHRgAJY/7jTRyRumVeVGYuOw
 ZpJ6/vbHC44hr3gqfA9lCdmKPKz2IobsRTLOmKhGuCBQRx8B2ZDAJylHGJvL+NdKxgsDJiD9nQK
 YhuHWZXz/OGzn2wHuWkLfHilUfrep6/mLeLt9g/H9kNL8GJBUS1JsX+vMtQ9Tm3Q+85cRcilaFh
 1znbeW/RPfkbiDu6Nu2aDUMkZ5SECVQfHdbDh57ZqlkPKq5bDKy4lo4LqvKfseZMTKV9s9bYgVD
 J6Z5yyGnYsALJRBgQhkxhvmfmRPk=
X-Received: by 2002:a17:90a:10cf:b0:3ab:9c73:12e with SMTP id
 98e67ed59e1d1-3ab9c7307d0mr6335001a91.6.1791958130556; 
 Tue, 13 Oct 2026 23:08:50 -0700 (PDT)
X-Received: by 2002:a17:90a:10cf:b0:3ab:9c73:12e with SMTP id
 98e67ed59e1d1-3ab9c7307d0mr6334983a91.6.1791958129984; 
 Tue, 13 Oct 2026 23:08:49 -0700 (PDT)
Received: from [10.206.96.212] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f280fecsm2972568a91.13.2026.10.13.23.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 23:08:49 -0700 (PDT)
Message-ID: <0a901acc-fa5c-40f5-a468-5280cb25a71f@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:38:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: fix AHB clock staying enabled across suspend
To: Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mahadevan.p@oss.qualcomm.com, rajeevny@qti.qualcomm.com
References: <20261006-dsi-ahb-clk-suspend-fix-v1-1-67da848e1b0a@oss.qualcomm.com>
 <5380b2cd-48f1-4e4e-8a11-9e303c366e47@minlexx.ru>
Content-Language: en-US
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
In-Reply-To: <5380b2cd-48f1-4e4e-8a11-9e303c366e47@minlexx.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IpOL47/g c=1 sm=1 tr=0 ts=6acf1c73 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=xTD14EHqjbr0US1DkR0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAyNCBTYWx0ZWRfXz69e3QmGOjTK
 T1uVO8ERkOwyHsFKfhEVIKWJ3Dk+eHb3TsNTtJDN5ywZvwd8ribnU2nCQ5fW3jQvjoum/mdHzb7
 MkGfxYb3bcv8tvxD37vjXP4VboBXMdqh90IlZb/mOmhBWBW16iUi8lcM6/UTkt/XcnQNK8HSIBM
 18y/9Gmq9XFdii7Pf3OarucAJppcEKCHEo+eAdjMhZ54VF/Vj78otZrOHM2gNQpjk1uG9j2uxCs
 bqqancGscPsYfTXA8/IR7BzIK67+Yk9i/EXgbxa2Va8KlqBaPw+5ArwhBQMgXy0xre5gQJNE7LX
 9g8CsAeKolmO3mKWOaYahYtZG725a7CbW6tQFX73EsmWOPX2pT63PDu7heaDXkt4357XtNx7RYh
 Bfoa+OIDEpGI6gVb0V/gfeS5pZCSgq++QgI9+cKEBJZ1h+lCIuHnI28d9jHMvUBBfU9r42XwFLl
 iM+TGC2VrFJPKVBURFw==
X-Proofpoint-ORIG-GUID: sh4qGy2VPLc0WfmtQH7Iqphpr8sCExdK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAyNCBTYWx0ZWRfX378wAoNo7s3+
 JnREdgbRni1OrVu/NKek64zZHjAhPDlfSlw4I3WlvEZNNfqY4rob0R5YsO/kjc1KZCQ6nf3T5bN
 qN7r5voip5WVvrOyWOuXjqUDwy11F18=
X-Proofpoint-GUID: sh4qGy2VPLc0WfmtQH7Iqphpr8sCExdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140024
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



On 10/9/2026 5:28 AM, Alexey Minnekhanov wrote:
> On 06.10.2026 16:13, Arpit Saini wrote:
>> pm_clk_suspend()/resume() only call clk_disable()/clk_enable() for the
>> AHB ("iface") clock, never clk_unprepare(), so prepare_count never
>> reaches 0. The clock (and its source) stays reported as enabled
>> through s2idle suspend even though the display stack is fully
>> suspended:
>>
>>    disp_cc_mdss_ahb_clk [19200000] ->
>>      disp_cc_mdss_ahb_clk_src [19200000] ->
>>      bi_tcxo [19200000] -> xo-board [76800000]
>>    disp_cc_mdss_ahb_clk_src [19200000] ->
>>      bi_tcxo [19200000] -> xo-board [76800000]
>>
>> Calling clk_prepare_enable()/clk_disable_unprepare() directly from the
>> PHY's runtime_suspend/runtime_resume is not safe either, since it can
>> deadlock against the PHY's own PLL clocks taking the global CCF
>> prepare_lock during clk_prepare()/clk_unprepare().
>>
>> Fix this by moving clk_prepare()/clk_unprepare() out of the runtime PM
>> path. clk_enable()/clk_disable() (spinlock only) stay in
>> runtime_suspend/runtime_resume. clk_prepare()/clk_unprepare() move to
>> suspend_late/resume_early, avoiding the prepare_lock collision and
>> actually dropping prepare_count to 0. DPM_FLAG_NO_DIRECT_COMPLETE
>> ensures these hooks always run on sleep.
>>
>> Fixes: 0b3ccb76b95b ("drm/msm/dsi: Fix 14nm DSI PHY PLL Lock issue")
>> Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 132 +++++++++++++++++++++++++++++++---
>>   drivers/gpu/drm/msm/dsi/phy/dsi_phy.h |   4 ++
>>   2 files changed, 127 insertions(+), 9 deletions(-)
>>
> 
> Hi,
> 
> is this supposed to fix the message: "mdss_ahb_clk status stuck at 'on'"
> during suspending?
> 
> -- 
> Regards,
> Alexey Minnekhanov

Hi Alexey, 

Yes it will fix the 
mdss_ahb_clk status stuck at 'on' during suspend.

Thanks,
Arpit
