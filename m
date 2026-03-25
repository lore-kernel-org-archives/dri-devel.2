Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D3EFEA80A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE2C10E7A7;
	Wed, 25 Mar 2026 05:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eHKZunOS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YnxEJkTG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073AA10E1E8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:32:06 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P53JxO2340457
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yJXcJrbiJy17hwIuQ52cwmME3dgQ4SPK8fzGNnc0/FE=; b=eHKZunOSvGc9YZ1e
 WsYI0pLy2Chlisn9xaQkRkdSputxbjC6NZseQiql/uOB4dDwM5oiKHS/fOH1k77u
 ySyZfDvQje+HobfIUtGc3zUSKK+dnt1lkDj3FkzryX8pXsbI9OdeZBV4U8eV+bUB
 zlTGFFdfcNFJPRGvJnG9pEv5NwYc20hNUq6kR5dresbBJWcYZXqf+NmMbBD4vXwb
 EJ7NKGgWTnGlby6NcNpB0upw1T0C7kk689AIiweAPl0dcfyuFfCAd2Xt8oPFNvsu
 IxucGJbSL9OEqK+VIuvaSZ8ZamxCCvdYtBdaMtXAl3uoOwdkzTIpcLnxp0oxYpsI
 ge+LPQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw43h5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:32:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfbeca17b2so228929185a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774416725; x=1775021525;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJXcJrbiJy17hwIuQ52cwmME3dgQ4SPK8fzGNnc0/FE=;
 b=YnxEJkTGvlX/an+iZP2rF7McQdBOMtEuyx+BUIEy+rIatq7TAIeLq3IozLzepHN443
 iObROaKsdTtQDDp0RbHbD34n/Qx0L/t8Q9suij/9eWV51qudxBRCb6vtzgLEDt4Y4Hbk
 0W28kMnwPPLYFY8bZfy3UDsEGJeoy8v+6ecLnIw0S7mjza6+upjnEuOdI976xAxFZeLt
 lgQ78nCt4PhzJLn7k0AE/1K9IMGZk7SVmxUvEFQsSXjg9MbBiscnm3rtG9DPB+VaRbQV
 JkhGPD3IIfkUFWpEO60OShyTD79MnltPHLPgG3uvsLU2CIojLB4tMJA47C+jXB52n9he
 bSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774416725; x=1775021525;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yJXcJrbiJy17hwIuQ52cwmME3dgQ4SPK8fzGNnc0/FE=;
 b=rqpHWcTqbX6vI+s3cdc+8axO22DktZrE8GhBl1ShOaWO0C4P5x/Bam7kY9u8OnMUdn
 bVxOZwixF8YkM+nVJIl4X8XlwmkWntZ9tvV09tOKAsTRhMVlZt5kxM8mj1pG2/r0FLDu
 9oVND6uUKpFhLC8MrcYSttjSkqU570KHUnmU1WlLaMouHfyRVaMUZhkEz6P21cib5cSj
 mSdETI5UgJwvr4GVqMW+sYRWmzeLr6qi2//b5XI1+XZRNahiEr17WEuemRLWGhVthYx2
 bzv3RoYW+5xjN/U9j98CKhDw4p3izy6EzNR1t0lNDM+MtnbgdEDlNChCzCL+HgmTGD3h
 NPPA==
X-Gm-Message-State: AOJu0YxzrH68v1oeRYAGZY+gpZ5oHGquF+w+OeRvoIBJxYpLUJ8I/Yoi
 vbTJFL2DN9YaMEQSI3WYspCLcqQmMEvUxOxYq9AcndX7uIWTx5QR64x/YGhludbQ44Lk41pIGKy
 7PVJ0mtUNmrBi/Aa9bq/FFRwbp6DA2s/esAc1nmiTqnkqiW4HBve8Py/am5MjljIyYwUiAsc=
X-Gm-Gg: ATEYQzyHL4DT4MyXwXdrYiWrmOLwx4Lg75vcNyorxbdsjuLfwWZN0FC/dZVdRVopxyR
 LOnPRy1vp/tLVsL04HF/u0US0gQYY7m7WCO2kFkYXSwRl0vdFWHFLdGqmBVEf177e9xJaikPPLz
 8tKChgYFx+9/VwU9IVFpMreUQdngU9qJH03VAdbFs79lu+WDfF3aV792LU9XK/6YVxuhw7mXutI
 oSy63EruF6gksivdqFeJJejPscvQ1QEHZF9MIAjMiQV6A0qbuELPitpqZR3MY3GAGkvzmla58En
 F9bYtLSPKgXyGUFljRFJ7u0841O/NqdP4Mlgv9gLa0ilVdJslUoRwjUUm4/+4PWNikGBezdbqSo
 0dqDyOJ1ntBx+6ep4zubQkbydyAag3M3xVuASD1hCc5I+15J0xbFbfCbIHz04oWbp7suWdds/m0
 NP+V9H6UQkldpzLoVpm7I+49HQqK9OfjB4/KU=
X-Received: by 2002:a05:622a:8359:b0:509:2231:977a with SMTP id
 d75a77b69052e-50b6eeb8f18mr68707101cf.30.1774416725252; 
 Tue, 24 Mar 2026 22:32:05 -0700 (PDT)
X-Received: by 2002:a05:622a:8359:b0:509:2231:977a with SMTP id
 d75a77b69052e-50b6eeb8f18mr68706971cf.30.1774416724785; 
 Tue, 24 Mar 2026 22:32:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a298cadec8sm826983e87.32.2026.03.24.22.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 22:32:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org,
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: daniels@collabora.com, helen.fornazier@gmail.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, valentine.burley@collabora.com,
 lumag@kernel.org, quic_abhinavk@quicinc.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 linux-kernel@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>
In-Reply-To: <20250328110239.993685-1-vignesh.raman@collabora.com>
References: <20250328110239.993685-1-vignesh.raman@collabora.com>
Subject: Re: [PATCH v1 0/3] drm/ci: mesa uprev and
 python-artifacts/check-patch fixes
Message-Id: <177441672330.329970.5922858810537905808.b4-ty@b4>
Date: Wed, 25 Mar 2026 07:32:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAzNiBTYWx0ZWRfXzUQRoDxSwn2M
 PzDHd9rKe97PbojobrgYca7kSBwFW9BfQO0/ne0S+udJuiT/NWct3ASg/r1ay22HDbdMGY9p0gw
 GN+FfxXgYRIu1kIZ3N/XS+421M3ZSDdqa2DIVLNEGEzAdkycC878R35uNMweKDtc58ERf9L36om
 hXW4cmJdn/AJy0s5TvYmkis27DvL3d4X3JavgH5LdXBQ4sVwJy36ptvKR5TFskK6CrmYJXVuuYW
 jpEsL9mGGJ6IWddbfn2WvOWxysYHzTlYNEvUspKA1rQrxKi1Ubc2hdLVeujF9f+S1HdF2GKtNZt
 JSTnlM65aEQS2Jd8nzkYY4O28vQCsLOr1jYMMNhYDMVYaLDZfyJpzUG3hhDbSwmskvpMYTUO/rJ
 ue/JAq7R1WBhXHXcUgWJN8D/0Ejlg5Y0Ae13whO+TllbfkKq70lZUthZOCuBLCkvJVVMFOFu9h2
 1nPBo2+6oLPYQHp0FgQ==
X-Proofpoint-GUID: PhXuNdsKPE0FsMEmo-fEuHwpzAsvxBbY
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c37355 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=MUhokysQIna2iugFadkA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: PhXuNdsKPE0FsMEmo-fEuHwpzAsvxBbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250036
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

On Fri, 28 Mar 2025 16:32:30 +0530, Vignesh Raman wrote:
> The python-artifacts job has a timeout of 10 minutes, which causes
> build failures as it was unable to clone the repository within the
> specified limits. This patch sets GIT_DEPTH to 10 to speed up cloning
> and avoid build failures due to timeouts when fetching the full
> repository.
> 
> The check-patch job is also updated to ensure the repository is not
> shallow before fetching branches. This prevents issues where git
> merge-base fails due to incomplete history. Additionally, the timeout
> for the check-patch job is set to 1 hour.
> 
> [...]

Applied to b4/fix-dp-mst-interfaces, thanks!

[1/3] drm/ci: use shallow clone to avoid timeouts
      (no commit info)
[2/3] drm/ci: check-patch: unshallow repository before fetching
      (no commit info)
[3/3] drm/ci: uprev mesa
      https://gitlab.freedesktop.org/lumag/msm/-/commit/0bebb1773d61

Best regards,
-- 
With best wishes
Dmitry



