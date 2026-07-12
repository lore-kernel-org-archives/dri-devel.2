Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7BBC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48C810E4F5;
	Sun, 12 Jul 2026 23:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="krGjgT3D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bDvC+hZ7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590F410E4F5
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNU5O23692664
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tvP2PU2uWXO8rZskoBmIWobxLxqa0EEPaN/AyMJMkbs=; b=krGjgT3D8IgRDS8t
 StM/YtuMLvfxfqnk9ggk137K33VY3MNg71wyYm2c00GMUQhPIZbLilRoToNF6KS4
 TMyA1++qml35efp6oZ5my2C9YIviILyzSEwFRsFal0unSeHJHZGiesj3jdNUCYK5
 ZJbZdjmurJ8xek2Z3Z/4kp5JIgW0Ezyte9va6clqiNk6Eu9Bizy2RCp1MHHejRfS
 Pu25KUMSjY6tnwIWJXqpOvzPt2hrghJtvweQlwa3m0czB0fMOhGbnZE8KYetUbSy
 TZYNdKHgsLcbFMkM5Lauq4qoawkgQXP9Sz2/u0PcTqBFOKPRr+tsNjs9p2ewILIN
 MSsSrQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf0gkmfy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-904c1d588bbso12317066d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783900004; x=1784504804;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tvP2PU2uWXO8rZskoBmIWobxLxqa0EEPaN/AyMJMkbs=;
 b=bDvC+hZ7IRXOJCuSBjg5ITDoNXoD0IAlS23+R6mOHzTVkmoVCnknFrzxSCgreYzgM4
 N2e0h3dp5mR+PyH0hHI3pCCfeu4VAF3BHFVbs+iTQIwHtXIHKnvtjorW5FGHhlwXprME
 JlSq4ZUupAMzyVQT8T9HgRtUHcluVoBr0kt/tyNI5CUTZ6KeIhljonNfyQhQGBColBJ6
 Z/5xwr7hu92TN2Csm9UGD1/dBmz6TNZ8yRCaHuCw2llwxuNTzlYg/JDcVIATzh1nbCF7
 53IQ2AkFe3oCd112kgazk/8pzgUWaWPx+sdsxG/DsQXNCAaYlU4qtiWHtEgfMepk+Eii
 sYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783900004; x=1784504804;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tvP2PU2uWXO8rZskoBmIWobxLxqa0EEPaN/AyMJMkbs=;
 b=OnZPh/SCaBjsYZ9BT+23lC+w8VXfrGFMruEp7gFdfouu37vEWpvObZjlXTt3SCF19j
 VnytUoQyH6AoKD78fr4t/8PwlP+p2ZAw3L34CMZgxi/8LNmT9kWyInIT3vujQFzEc46q
 nWVKa7ojkJ+jmlEcmxkcebiKiUqQMzxO4xzh5TFAfN6/nkoBln/ZCE11EQqqSoKzTpDO
 tvSeOcKiNwmkWVDLZSqasqOTPfwvUUeMR5A+129gwcXb0HfiLjxZsg8uHOnqEc3cpq77
 4wv64Xac7gxYTi6lEUGsTqK27ic3kjdR52IU7/Ur4JKUx2bB9UWM/oPt8/pQBEX9ccWj
 nt1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEkxhg6WZZ1bHafoi2cF0YeK7GPm0TLxQG6vO31oIQAtHjlInl8oDJBMAM/OrAIhiRn4KTAKzjyuY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvVShFtHn7j+S0VqXCxLm5LhDTpKEa557tZSwmm9WFxT0h+8pe
 AzjA3qphXUqN0v5fv4jb6eaWhqn8CNrqnT0EGtCoW5SCsTI6Q/2NdYexDHi9mY3rRAfVoq/upAC
 xHl08H+o1AZQK3CS35CRtVDCbEG9PTCmJzXKHFaryVC5LTPgQqqrF766OcxNLuNiWYc8wa/Q=
X-Gm-Gg: AfdE7cl/XVh0N1RvrTd97o6wv+UUCqvd6S7faVCLxaZwOSR9Dsg5Z4fJcH3Eaeub46j
 buiaCZ5GMeIqtuQYJWjtzbOf9rvrmVuMIN5FvrzjZxPFC7VFQCcF6+52p7KXh3+A1azni8Ck/Ei
 7T5tGq5klAAkIvVZACa9STvNxve9KRCywFr/0abgzmX4CohiEZo0Bq4+Cg0DruA97VinvIacYNf
 /+9MKd7eEL3ptv7kLvs2YMJXtkKO7w87tlzi6KKhpNW5VtoF+gOcvwIeaOoZog1RsIMOPaT59nt
 WY4EIOs9yR7pkcY70FjoLDr0fspWn8d7Nu1P6V29G/7jsguBZcwZPxxb/BSu+epezvDr5bUDWO+
 e9a2Rl08x3W4nWM6ZAJLO4KlvaoEArgVgYMBSY8SHZzoPQZ0B7E07iFfJz23B2iLCiDEeiSRetQ
 2/wGAgMN612986u8udNfFhJg3K
X-Received: by 2002:ad4:5f45:0:b0:8dd:2260:70df with SMTP id
 6a1803df08f44-90413e0a3d6mr94800076d6.6.1783900003795; 
 Sun, 12 Jul 2026 16:46:43 -0700 (PDT)
X-Received: by 2002:ad4:5f45:0:b0:8dd:2260:70df with SMTP id
 6a1803df08f44-90413e0a3d6mr94799866d6.6.1783900003400; 
 Sun, 12 Jul 2026 16:46:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01caaf40esm2371357e87.71.2026.07.12.16.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 16:46:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mohit Dsor <mohit.dsor@oss.qualcomm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] Revert "drm/msm: dsi: fix PLL init in bonded mode"
Date: Mon, 13 Jul 2026 02:46:38 +0300
Message-ID: <178389962791.1434604.17881229374549005911.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712-msm-revert-dsi-pll-fix-v1-1-40122689ea25@oss.qualcomm.com>
References: <20260712-msm-revert-dsi-pll-fix-v1-1-40122689ea25@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a542764 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=d5EI_OdSFrC9Nmgep-EA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: doRyJW2dLusoweSG6dZ1MfPNjTFVRK54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX9DfEs8pqMJ3a
 S3FveF1U4V9e59enBLfhlQtnKH61WKJhIxc/aJcznLI4eTy0mW+yMSqZsleCu25p6ssX9RuyrEQ
 mwv0io/KksZuU+Lxo4YmknK03tM6J8zQclYLdu55MiOc8pSw2fEmgZbQvRNVS0u4JIkKzya4JtB
 uGn468JL+tEDrhOGVKoWb3eJkQOtQoShqanRHerYimcb7z5PrCteokbj3ChOy2DKybe3gaFud3F
 e/JycmROzJiLmvaFbBmPoyz5jsJU6+0XWOTfvxi3dgmUwVbWkWoPhxtxIhS8tinC+5DNu9HIn5S
 Yu2b76PjhBjtptz6iogDWVbY+mxfY5ldpi1DZjS090SNavbg6z1JmXK1BaOasmogwd7+lddjgug
 Bfd6ojjpsjeRPDa0FpCGdsiZ2xs3A9mIR23M/l2N21rC7B+cSNNKaJkYJg9E23RleEy83P71a2u
 UJfC6t2FwNuN3mDKd5Q==
X-Proofpoint-GUID: doRyJW2dLusoweSG6dZ1MfPNjTFVRK54
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX0MeW0U4d0rw8
 tQx+vtxk6goT20SzYZ49Svd82RNHn+fIw5FU0/vUKlooybWu2XWhnvCAt8naEC/31vkACMalcWg
 L3lhJFtdpoiu/pCCKkATU6rwmL6yp90=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607120257
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

On Sun, 12 Jul 2026 14:56:55 +0300, Dmitry Baryshkov wrote:
> Commit 93c97bc8d85d ("drm/msm: dsi: fix PLL init in bonded mode") fixed
> one of the issues with the DSI bonded mode, but broke non-bonded usecase
> for DSI as reported by Mohit Dsor. Clock divider is being programmed
> incorrectly, resultin in the wrong display mode being selected. Revert
> the offending commit, letting Neil to work on a better fix.
> 
> 
> [...]

Applied to msm-fixes, thanks!

[1/1] Revert "drm/msm: dsi: fix PLL init in bonded mode"
      https://gitlab.freedesktop.org/lumag/msm/-/commit/44784327815b

Best regards,
-- 
With best wishes
Dmitry


