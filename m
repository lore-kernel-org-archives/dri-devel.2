Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524EF10F286C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8720710EEA5;
	Fri, 27 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fsjdMBjU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rn9bRZNa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8351510EEA2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:28 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2gWO2218021
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xaf+EJhyxzQmyb4o/ktKUdNiEpWBngVq9vn4kthy+m4=; b=fsjdMBjUwm+cIPeg
 5Vi57L/Robb/Ahme4zcuz2/zE1UND5C88kdewbHjNbPYevUK65K0vefDAaEIkfpD
 HlhfRUEqtsRk89+5sf4Q0WjF34nw5E4sv/yzwEc/HkWWr+GsgArD5YzzzluuCC1F
 1uyeNqIaztgK8jMrcS9y3/gceBBlREa6sJn2bWOrMDDMhv1SjfTXAY2eFiYxwxUU
 cDAgeLCxoBzmk/kGCAWOg7cvw4QGG0/Slgu8UJsXEkdlWn2+s35mPqp7uXAAycaS
 1IRsp2wPHmdRlErqIwPLbHuE0Y/vgRV1zBip7y1CWYqM/fQC6LHT2M7F4wPx/OUt
 m8pdhA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5w30rqx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b274f94f8so2979771cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640907; x=1775245707;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaf+EJhyxzQmyb4o/ktKUdNiEpWBngVq9vn4kthy+m4=;
 b=Rn9bRZNal+8JAFlYuQSRmluzi2TTm7qto3xluV935JNBa2eM9H4rzuuHyla9tyKVWI
 tN8Owt2PHPCEtXihIh6/UgeWFKOlsGCrNyPD2mTwRP9S5ckgKqWZtFpNP/O5/+i7T/MI
 Cr66CdjTN/XS1pRRe8KM9YMyORHXy98vSEzGT9HeY/7D++Tk3mdF2x5YYDduCrhsFQMX
 B4z+ARRNfID0Rv2ncLhaQ6FlESXrVePllGaGhpSUz3jnD8K0dLSuz0iDiBQI9kd419ch
 JMgfIbrqNO5eIgvvTU5HZe+mite32I3XLY7c0HQpHymHqSZHj+RuITWwpxcvXQZLdINA
 jyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640907; x=1775245707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xaf+EJhyxzQmyb4o/ktKUdNiEpWBngVq9vn4kthy+m4=;
 b=ZOKXILKv6/3Vc3oNlg3Gpd9rAaO8pQmehopzHkuRwct+50dpJyjkq4PpvTOvrj9RFH
 972j5A+rFBKrOqZMasBwPEs4Ybt4ccoHNTB+3vxA7V53Y2/nmV86GEtq9BI7IfN5TPan
 hp4fJ8bSicyGdNUDYOtxkldL/j29+Oo+dh83gPNzMylNpIl5V1IhYvR/pPlCLuhXQE67
 KC3t6Lw/cOMr84h8GbGOfp+bnhk9PC3ZjeXmoIIxy9nyFLivJ6buqskofAAGuhfwnKla
 TkhdmYcO/+m72y9LJNupyvaj+dPq08KdQqGKnBXdmUCZskkOQjzDWsmnei/TQojV4sIw
 cSJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMj6vnhVrVT63/u0AByv4yE7g9F7wV8xc8oJxDiaXZRiGBwyJYWDie/Xqlh00zMz4etG/Gq5AseMc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRI07pi+lgytivlttN30q1zGV8hFzf7c8ABnfMzzF6iiCiqpVw
 OOMsxiPThOKGnScHoVeDqKWl4bS7JL0VU+kdYJUMcbMQvt1AJy/zgdwhX2wW0Ee3d6GlpzwsVko
 MktSXO4iTR0fQwWmnA3L+V343P9Kv2ytelNBT40yk3+gkKh+nUErrqHWba4IqDZoShblYeDQ=
X-Gm-Gg: ATEYQzxIGwijfumftjbPBVm2lHe9Hir8vNVe66irGrFFXBjkfFqtS29DuoEubi/QffN
 1/nqYofVzv7+3DyUe5kogsrwAoyMYh8IkJRLoZLE53AWUHMOFcBjKfvMdOh4nMHRQaUhrt6kdub
 Aj0j+YJtd6/6TuP4hID2l2gLeMKGqCxtNTs1/awnvepvHrGKBqE86Er4xS6pqwJB+4BXIbX5hRR
 vJ0OPvMGhM7hpD3ZxAD2eqyIQddtX1UhOug+v3IwWoiI08Fabk5kpTRY6+O1bB4zYXle/FLLzF/
 aizYy/oTtKuLivCqJRur2zNRTh7fTmNzAcGwEu9UhMEKiN7/BGHrOuGRMw0D9JdIaTafaEY3GDK
 GMtMR0o9GDu8AsCXvnFNVKlCnHQap7erNPyBGOhQFvH2iIXYR+vZ7ECcBKzqTgqcnyvZzIf5WFr
 nSvkr76t9IVhQ3bkFqc8nTPW4F1GZDTKR6
X-Received: by 2002:ac8:5992:0:b0:50b:46ee:5aed with SMTP id
 d75a77b69052e-50b993c6a6fmr84329211cf.10.1774640907072; 
 Fri, 27 Mar 2026 12:48:27 -0700 (PDT)
X-Received: by 2002:ac8:5992:0:b0:50b:46ee:5aed with SMTP id
 d75a77b69052e-50b993c6a6fmr84328671cf.10.1774640906583; 
 Fri, 27 Mar 2026 12:48:26 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tianyu Gao <gty0622@gmail.com>,
 White Lewis <liu224806@gmail.com>
Subject: Re: [PATCH v4 0/4] Add DSI display support for SC8280XP
Date: Fri, 27 Mar 2026 21:47:54 +0200
Message-ID: <177463970833.3488980.46426040533799484.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260308064835.479356-1-mitltlatltl@gmail.com>
References: <20260308064835.479356-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nszggoxzTfTeqIpjtiL-lnEy6Dr7tIko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfXx2EbMPsMQetB
 fjVgY0MFuUewUcCowEbjXPR0c+eawUVIzU3peOtWqTtXdSNC1aFV+trJEdQcFSLBCfqi69DGlMm
 htUIQn16s4ezEE1VdpJgsv1dMVnru8Ta2ZfmuR1uJ92L5sAXuToex9RBSImK6jVMp+57uinNcP5
 kChxfRtfxSOHFje+h3BTbgZDacTSolfQVCzoXTP+z2kTg65lNi3uSKQZFMNIMm+grQRQJjPsKjQ
 q9YlsNDpfA+i3bBSrbiL5GQQvpA+5CNVqVEzY3pd1XMvhfh3omCA5nL23XXgYLUn2eae89IIGBN
 XDa1fQ5V1A3DZcdx0ywH8LB5pote9ud+98hcyOomBLzP2rYqRizSgSAPvM8xyqZAGSFo7Cy5TsB
 4lvSEKCM9w0RENhGQ9ijmkyiYQ2ZIDFQHkzRBQ8gVxN2Jk6QCYyFn7mfpMFRe1fhUu23JjbzHPL
 CnoOlEuk3kYg9KpTX/Q==
X-Proofpoint-GUID: nszggoxzTfTeqIpjtiL-lnEy6Dr7tIko
X-Authority-Analysis: v=2.4 cv=F9dat6hN c=1 sm=1 tr=0 ts=69c6df0c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8
 a=qwUskhSXptgb2aVpTsgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
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

On Sun, 08 Mar 2026 14:48:31 +0800, Pengyu Luo wrote:
> Add DSI display support for SC8280XP.

Applied to msm-next, thanks!

[1/4] dt-bindings: display: msm-dsi-phy-7nm: Add SC8280XP
      https://gitlab.freedesktop.org/lumag/msm/-/commit/59f6bdf913dd
[2/4] dt-bindings: display/msm: dsi-controller-main: Add SC8280XP
      https://gitlab.freedesktop.org/lumag/msm/-/commit/1607c084b18f
[3/4] dt-bindings: display: msm: Document DSI controller and DSI PHY on SC8280XP
      https://gitlab.freedesktop.org/lumag/msm/-/commit/6113aaf7a5ce

Best regards,
-- 
With best wishes
Dmitry


