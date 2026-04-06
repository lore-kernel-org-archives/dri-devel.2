Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED79FB5175
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 23:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A3B10E2F6;
	Mon,  6 Apr 2026 23:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XeI5ITP2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjAYWf45";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26E7010E2F3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 23:42:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQHTm3536962
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 23:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WNsoqgn0qsYo2CivFYV4W61GsPhxl1xr5ncIUdQYOj0=; b=XeI5ITP2ibIhprO/
 d2WcEa+/EkEbfZFdLa6qvGWt+wRawuASQFcnHwWdERHcbot13k3gNC7NdSGkCFSS
 peTTMsq0Tlo8qs7dIQCbU21IEaAMGTI+AmuYOl1MibAeQlx4T39DAqlV0WFi0h0H
 QOPncSey3xZUuLT8bhUbHkcEImGVzylW2Mv9rtTUsUJpX/NpFp+OgNfNthIS2CPS
 vzvVVhltulKyZphZqPCvZawq+x4IuJ942nXTnOgjggTw4J99oI+pmr9Qk/g/yGC6
 gHUFGVlfELJrV3vn5WiiLbEWuQnyM8PaspfrKWIR2sznRrBQZuPOvURyh1kQJ5b4
 e5iSVw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra090x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 23:42:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d58bed44aso142127071cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775518931; x=1776123731;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNsoqgn0qsYo2CivFYV4W61GsPhxl1xr5ncIUdQYOj0=;
 b=OjAYWf45v3oYfyG4asLB4Ro0vSkb0KU4Oh79ZDQ+y87Xm/Hrif3Xwuo+kEp4K1dbLd
 tSS/EscuVMYcsOVfZY5KfksMEqxxw4Y7yAai6U0Fc12qX7zY0N1L0FSAWVMkqCKQV7br
 EZHiB30eI7ezWCmws8ncAF+E/af5K7SStAA/ZZc+9OpH/l7bU/z6T2Y++IKufkDONWZW
 cCaHXyf4+0FCIcijNawBJ4tMEjKAr9QAGLoz4hQPEmquNIyiCDUCJfH7YtOsqFtVtnCP
 NNKKH0ZfCrZN429b4Fi61DirlyJvrLhf9ejKnfdTX/zjqjflRLeV1Ep0WVVXOJ2YlUe0
 /EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775518931; x=1776123731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WNsoqgn0qsYo2CivFYV4W61GsPhxl1xr5ncIUdQYOj0=;
 b=DHoDCrMSjeHmQUswymlWnMIaL9DyteMGRIuQvOTyXm95OvfladJWVKQUDmxrp6TII/
 4SarOzlpDZhbJeYVx2ifcaYoXfpbc6LSuzY+vIPBy8tO4C/u72uJrv7NA+O4UNRjP2UJ
 kcYD2obzzESUJ9Vzs7n/rKtyvqAB5XeV9xGD6UqgsTKJYgD/vQSrVarSS8781LAvI6jo
 KoQ7PkS1fGIp4Nw/VW5dpq/qAd8Cs+UoNUL4Bl47Kc2SAp15Byn8RTfiRNWKjBJSLrFc
 QJO9NqirnHoVdCV0AC8anfBudr7BifeOAr5ti8VMq/LEvTXqM0vR2Py7kpveVMY6h3Vy
 GcBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcy083g/m+fimeGs5eHeagVrkX4rJYB37bxq1QAytAwf1nn0BwE5fp+mpTCA2U7eAqDnBZPdRCTHg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9vYAxTrAYb2MNs8/0iYrBT6lMb4v5MqGpUWMEE7AM4y2z8Vh2
 MW9QG7PbSBoezHDJsljXqvzXrQXecIIMOmT6wfBw5IkUuDytvw8s9+6fkwd3WQxeIjdYD0JTRj+
 34qHOmwRSxEAc8lnvn9+U0r1jJOvn4VfXJkqrEyCY70oWtQtlZ8BAQzjzM4tiuJVckTScyv8=
X-Gm-Gg: AeBDiesdP1/xIgao7duRkQK1TU/S714zrxsGZEVaBZuoh80cEsz04v9gsRrwjccpS5c
 dEUjoD+GR1JtTmDxs7PpWpy4CFX5SzsQSz+2HHvjSUWF/P4LTNU2P5s55BGYXbXnfh3WTjkhQV+
 J8tzP6i4fM8BLM051do3R0WyDtQwnpjq8jOK9ULYYukQnNPD36VIE4ppfyA3ycDgl+nnjHF75yG
 xgDqpDEGdqyY6OVnCCOlRAjxbtw/EiKekmsEFNQ/XZjoCs+MYmnZVMTu99wCoAypiFtTJVt0zCw
 k7I18U5j9nRJrvjBU2wJB0EHLoPZkPfLxbUBFjZN3H7eiwV1O2mPwlHvX7ptpcf0mWHTC9FBUtb
 olWODehJbRgJfkFUPOkH0qBX337Hf1AYnoSN/Vm4jhytHz83DS0KMx7WmB3fg+/odnUED4tUDNf
 XtMr73eiza/yzvDgEN2sse4TprnR5ZhuVI9Yg=
X-Received: by 2002:a05:622a:1e87:b0:509:1dc8:e9e5 with SMTP id
 d75a77b69052e-50d62a7f7c0mr232213211cf.34.1775518930712; 
 Mon, 06 Apr 2026 16:42:10 -0700 (PDT)
X-Received: by 2002:a05:622a:1e87:b0:509:1dc8:e9e5 with SMTP id
 d75a77b69052e-50d62a7f7c0mr232212991cf.34.1775518930256; 
 Mon, 06 Apr 2026 16:42:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd217c708sm33512011fa.39.2026.04.06.16.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 16:42:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH] drm/msm: Use of_get_available_child_by_name()
Date: Tue,  7 Apr 2026 02:42:07 +0300
Message-ID: <177551403335.616257.349939919049063044.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250201155830.39366-1-biju.das.jz@bp.renesas.com>
References: <20250201155830.39366-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Qt8K_JEquFz-2YpH5vmmjzYa-_8HAV1C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIzMSBTYWx0ZWRfXwPXMBNZErtR1
 9nwgwF52Bi5UG03GiAVqbg+BfHgFWLfCPNfwReurQCskch5wrVRaMYQhEoUdmnWz+J9BjFnc7/N
 PG6+/u4nPS3xNdhwuNZrgsT+KDZLEbRqDRV4Y5obmhatrvzP+TTt67UPHKiR/1ulplbkW2AQ/09
 eCS8vVDQ5G4vQAk6do82lOpjBxWpTjwHVwdjhzn7s/h7/z++em/SSQNZRgZDGczkUOHMtX3ArVT
 seg4x+b5Hu1W2dKpabizLIeBCjDpXljUYI1mgNUr3pRzw9yDjKK225zDG07MWgGB04m5aOxHHDE
 9CpQ6CbXoTUjkvhr3WkVlCpqoPuHpofCyMX0QYVuIA871e66XFZWN6o3UvyzLr0aXbRQ2IUPJth
 HCcBwDFRMWnLL4iPwsgbLm6K2Ldr2l2+EDZqeqLrT279T2uGq7bXdm2MJRiX5hx9NUYBQfR73ag
 zHsoZg6MpxTs/swr7MQ==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d444d3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=CaYzkkbPpyWDItnn5aQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: Qt8K_JEquFz-2YpH5vmmjzYa-_8HAV1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604060231
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

On Sat, 01 Feb 2025 15:58:28 +0000, Biju Das wrote:
> Simplify zap_shader_load_mdt() by using of_get_available_child_by_name().

Applied to msm-next, thanks!

[1/1] drm/msm: Use of_get_available_child_by_name()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a972d1b864e8

Best regards,
-- 
With best wishes
Dmitry


