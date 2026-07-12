Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2015C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 23:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CAAA10E503;
	Sun, 12 Jul 2026 23:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jF4o180L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SW9ILec5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E226210E4FF
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66CNX3Vp3948713
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4y8OHZ/EXAVlMihWZ1dk1clB/7sEMPnke8vGFcWsrqY=; b=jF4o180Ln8MEnBOY
 GQ05meA+hMD5C3g/Mg5AsMFDkeqRy6eG1nF01tr6ZNDMEQctXCv1kzfsfTSu/we4
 aLuIZh9FelCoTzByeEZv6BsuQnHwFcA1rAuhde5qwV0TVBOSTFdu1ZLgIUyfX+SK
 lNobd/weO8z0Wxr0tiX7OHpzQlTfZQ8uHS8CUc3x5LbeTc1qDTIyPiq436qMvxg+
 0ANdty6zqOOYGK9mx9vKLTGhHDct22sHkyZ6SFO8fZjRhQqJbveSWnO2fnq7zgMS
 cBIcxEZsZpl+pnFbxfyC8SFK0hm884Kmoed4z6Dzt0MWdwENQYYe8u3PTColkBoG
 OGchPQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr3mmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 23:46:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so50758221cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783900008; x=1784504808;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4y8OHZ/EXAVlMihWZ1dk1clB/7sEMPnke8vGFcWsrqY=;
 b=SW9ILec5zlR9rBBsM02m6oNCG/6J6o50IghHI2lb8UZ1b2sFnMK+ynOszN0VeflkkL
 WViuHGfEmzfRAiUrJH03zEMofJI51rDqY0TSeO2vF47ZNs8W7zFU4JKZwQQzCULrDWTE
 GeStF2cIkFnJmw4a0LQGt+NBF5om/lqGV6yTR51tiR/kfbDF7PfRoO19u/KOpm1r99YP
 dGiQ8CpsqnQ5N6RNRs3ddYuU+M4Pt/kGpnlL77SeKgePVZfrqKilk+aVg+ESYsIHaNqN
 hHhFKSJpbBcBQvpZbIqkfvIsUxpKuMClnzkvNCW7WHuCafx7bU5KsiJNjaMKTNAB1qpn
 6ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783900008; x=1784504808;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4y8OHZ/EXAVlMihWZ1dk1clB/7sEMPnke8vGFcWsrqY=;
 b=gtj6co3NDMJfaObj9KelB94QWEBaQTg12swcSLVQyoX+audyBltpOPnWP1zy19HTbA
 TA5INltgG/gKs8h5QQCtlK75R8Ys00q0P9Xhb8AelG9DSPVpvzm9moE8Cs8TQ2ti9yPj
 6nkE0xyobgr4tzcn+8GbFIA3ZhDMKLtYT6TYCuMbS3GwCdZZI+BOWrR3Tyxkkj3Zye/r
 ZUYTObGtVqvdHK01QAv7VvTg3kEi+I5h6mI8OKa0hhnn/fRQZ0jNQ0Bz1oPyjaSYZ2XI
 fKnLloHFoXWh53tjEci02mf8wkx/v3dYnSWCxkIaHFnfK9yRGKxFQiZCDs8qV8I7L4wb
 b7CQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq39TyrMgCLNbIW0b5bTMnxCxGBrP2kUCVyMaeJjWRf1lhMN30hHi6c9IX1E5w7yBS8P2egP1KgDiM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywx0sYlPnHHfGqGjM9sn34Do607Inniw1lZCnC4dIoHkE3j/Pj+
 b97QA4/ZuvF3LkB4oZ00WusVvbC7kcXrCbeb5HLfNmXlGex664Eq9KkSvQbIwYkI/kP2fcpc1AC
 JVD77W/O8XxscRKxOhmb0SN9jBLvbqkH/32P8NRCK58mg1CAV0ms9o/iJ5kxV1xXWGuyxyj0=
X-Gm-Gg: AfdE7ckGJMEy8qaII2VCBxCTAs8QyLEMBm8FxENODrdtDtJkwNWJ0F4dBsyWfOlMClX
 s+VQQY6B0D6jFtJDVKW2Wj8mKystINnhzzA3rKI6Z8c3aDVoUZiaL517dXuL2gm++iXwNGdKuR0
 StkUWFWv6CDyqBZxX1lbdK7YAWNAYDiHD4XVFiZSDgjT9PlO3ZOUTP5oueH9GQdyfG6b/nz+A1V
 WQRHvC9ari7+A1jZYCVDAOtbDsAJyCz20RJi4AEhusrPf9/aMk2IZdPEhOzTUvyI5yGgmO39Lww
 wAqWUAkOti3n46Ygb1jyvR8Av1E2GU/x6h0YwYOw/aUjlOtDzBm/9V28NakCZohRBaIs/G+QnwB
 KR/gaWd2as2jZAJC99PCjqkxU51cf6Mhx4wZ95PtF4yJlztT9kWBb7V8GNGO5UVcwKAtgEGZSe/
 N+wZnW/2P3Ey8Xq6dI86iJOmbk
X-Received: by 2002:ac8:5808:0:b0:51c:7b12:120d with SMTP id
 d75a77b69052e-51cbf3402b7mr73169541cf.75.1783900008138; 
 Sun, 12 Jul 2026 16:46:48 -0700 (PDT)
X-Received: by 2002:ac8:5808:0:b0:51c:7b12:120d with SMTP id
 d75a77b69052e-51cbf3402b7mr73169401cf.75.1783900007719; 
 Sun, 12 Jul 2026 16:46:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01caaf40esm2371357e87.71.2026.07.12.16.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 16:46:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Douglas Anderson <dianders@chromium.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dp: add missing drm_edid_connector_update()
 before add_modes on cached EDID
Date: Mon, 13 Jul 2026 02:46:39 +0300
Message-ID: <178389962795.1434604.5841714986393955443.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608-drm_plug_flaky_edid-v3-1-1ca632938e7f@oldschoolsolutions.biz>
References: <20260608-drm_plug_flaky_edid-v3-1-1ca632938e7f@oldschoolsolutions.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX83pyP7JChOAg
 7C41ucfrk+ZydF+PtH2DwVGTS+CyM70TrY9XpCDOTy3dYlfDx+Qo+NCt1XwQvIEePJ1X7RbncVL
 R2R0Jhux04D+XXdQK7mBJdEpi1Wrizk=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a542769 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=e5mUnYsNAAAA:8
 a=sa5PkiOI6JPz9RB1ZpgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 9ZcuSKI5VpNAMpmHZoGolB3o1VFnNWil
X-Proofpoint-ORIG-GUID: 9ZcuSKI5VpNAMpmHZoGolB3o1VFnNWil
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDI1NyBTYWx0ZWRfX6dg0GhFuYJzX
 YXPGxZ3OynkZLZRMNbEkukWw/BIToEzDs0DlYM6+NAmg0MhTEyr84jSAatrt9zLpMcJCExxSYT1
 oqSNe18XhAwlLrT8BQlPrMNkD3P2/MpKusBBrzPhJ3voy1EePDf2X6wRNbE8jK5lUZ0Iig6zkTJ
 UMZTX3q+L0itl91qwZ+ecRixz450ymL2KuF9104EBhF8uWlNLoVQ6FA04T/aP4I+Lx+dC4i/GkP
 7xquM7dfNxXNdW6Ih4oxXlp05PGg/VDAC7jBCwL5XFvvIpS/4+cCd+xpHjo9fZO6r8QZS9kcP+U
 WRTVMEeTKXKnn3u/qkR/VWOSOMleU3JpybW23miqWxhJwFpkoTU++z372emInwQPfAu+5iWUBFe
 /ophcsyEH6uJjG2rcoDSkFy2AqIPvgazkcPe8EJG31W5GM0alClNIQRw+fZm6acYSNOKoMBKDzE
 1/z7XWX5cOC/UTeopNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120257
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

On Mon, 08 Jun 2026 06:54:39 +0200, Jens Glathe wrote:
> After the refactor to struct drm_edid, the fast path in
> msm_dp_panel_get_modes() that already held a cached EDID called
> drm_edid_connector_add_modes() directly without first calling
> drm_edid_connector_update().
> 
> The new API requires the update step to associate the EDID with the
> connector. Add the missing call. This restores correct behaviour for
> the cached-EDID path.
> 
> [...]

Applied to msm-fixes, thanks!

[1/1] drm/msm/dp: add missing drm_edid_connector_update() before add_modes on cached EDID
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b7088d58dccf

Best regards,
-- 
With best wishes
Dmitry


