Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26247606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l4KQfzU9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q44UMVEt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE91410E5AA;
	Wed, 25 Nov 2026 04:54:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9306910E5AA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP2s6CE578095
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xR7RhWJqTr/aczzO3EIq1crgEudqfPhwaC9mSHTF0TU=; b=l4KQfzU9Rc99lK+V
 nzj0GpWMR9ZTrp+ng2TtKfpbVTLmMGKE/7Xq7JL3KIUBubUG0ACAJZPToxrlD+sQ
 3pu0vOv/lBWMNfHDGgTxkN8BfGVxREQMD0OuGmohCSHRoKMQTZuiAPq0gBmZhBq7
 HaqCbfXV7EE5oD2cuyNMP4ASZKI/yI2lKoGExHLw46voeEF6SD8pn4/BaXB1V+HC
 uhBUkk0IIflK8NedFUpB8LMPsI9fKiTlDRLZo3QdFV/FuT39GETZFrRu+BCSnnFl
 McRY2fZiqlknjN0ZviKBt1NVNPsj0B49N85i8UkpOtdO8I+l8aXGiCBWbTzIFzJ2
 OTi/aA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5qa28cay-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:54:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9211d51dcefso101318656d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795582442; x=1796187242;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xR7RhWJqTr/aczzO3EIq1crgEudqfPhwaC9mSHTF0TU=;
 b=Q44UMVEt1dr4mkV32C08BswrVUUFdZLd+qt7GQODYt4GRNsV8ikbPSB8sbRtpqUXn3
 q1wpzh/Pkx+vWzjsX8d1Rww06h/Ts0Wb78Ae3tDPCaw8lov2eHpqFEKl+PehN1lz8FiZ
 g1rVjV4kEq1htWPTV25l/wUEuASBo7K9khwPsrBBzpsUTHfzpGGbyNZPWyJwsfst0b+G
 tTX/puvPy49GEXhrZ9UqXea0G1PPN48vjhQfyoL0DNDBC3/tkSNoUEXSxitHo9pduo3M
 Mra5YyE49eB7hCAewVj6Yfu43soKPqufZFraALPm/M2Y9my6aVG8lIQg3iSg2yxZzvDv
 WkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795582442; x=1796187242;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xR7RhWJqTr/aczzO3EIq1crgEudqfPhwaC9mSHTF0TU=;
 b=s3IoA9JgY05QeQoLBIOHQEfxoWjWSKGYs0FN0yDbgOht9sWqLZXtBLr2SKiUNyDCqH
 sviRqx7YJrkN9XspxikSCjcK68YYvsaQFhGEUj8EXGyAKoK3v5EbzKyJbsz5b93a4F+6
 E26lhdaMhgYD2+wet6s+qVud0bA5wan6XnnuqnxOsKfJV6/pMQMQWvbwwcedQfZ5Bk6G
 T5ngYJOd2ecWlRYW108ELpyNa6pUtmwsLEldyc07GsWGq6tuHx69dv5i0VpxmswJHRst
 SsPFi6+oQNUN7ZDJEGIjhOZk3+Ah+BsNRPajqczjUMgpsnVT9OzmFL3pLzilSRxp0Yw0
 sFCA==
X-Forwarded-Encrypted: i=1;
 AL+hErETps9kzOeVX2UfCen6I20J7iQNUheufUwnrDlV095S2Yxi4vON1CiHrzTmQJitxPLSlEhRDVhzLew=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2JHxD0q6vwsSyW0eX3l7tyyXrXbv7pbUvj8pTgw190hUx3LHN
 i9WzyUdi37P7u/r9eoOJMgEXQrP2ODJOAjvY8e3eZni9JXDxAJ8Lx3DRGAjx7+iyBaxv1nOwfsX
 aVACs7pwuUm/fBbP146XaMyJmD/haE8Mt1DXdAnPfLBlnoPKf838cTB29rk6cZK8scIyjF2I=
X-Gm-Gg: AZFdTZchzGJ/Iy3clFrLk0YSQgTEc1+172C9EyoMwW/ZXUbllu6Pvq9ih9lR2JDSxiW
 +5+41BAlDQp6j1vWkBPYj1NexF9NOkJr+JfhAcQMBq9eDabi1PQZp02jQjiZhUJneRqs8eAEfaU
 Sh3pk5hPNlrFz6lxnK3clcFd9Y3chOc0g1qr0vV1k/kYQiZdKZBZJF0j1oGie32MRYBPnaSNnpA
 6rw3r/4JeDSrduDxwcZF+wz0bfCziu/6UQZssj0RGoVp/3rN8z2uDh+jARbTq4IlDeg0AevMsUh
 HWC+J56vPHXwwNwc6V8of7OdV/sMGDhbe3aKMedU6wWnc6ow9R8MJNLksQGIbXxhFc/j0S+JrlA
 9E5zJgExHYE8XcXef3OuAPrue1meA5oGVXEr0U+flXqmfRWg4No6pv1EJyTGLeLskYUDLPho6/w
 1B1YY/fksCsrzeaZQj1HYyaV8zm9Dew5DibRHfVGpoDOUMJwatkFhUKDpop1jo2g==
X-Received: by 2002:a05:620a:a408:10b0:94a:889:5a41 with SMTP id
 af79cd13be357-94a08896148mr24607485a.71.1795582442574; 
 Tue, 24 Nov 2026 20:54:02 -0800 (PST)
X-Received: by 2002:a05:620a:a408:10b0:94a:889:5a41 with SMTP id
 af79cd13be357-94a08896148mr24604185a.71.1795582442056; 
 Tue, 24 Nov 2026 20:54:02 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bcff6e32sm4243023e87.17.2026.11.24.20.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 20:54:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
Subject: Re: [PATCH 0/8] drm: writeback: clean up writeback connector
 initialization
Message-Id: <179558244050.1572056.6952667613622271304.b4-ty@b4>
Date: Wed, 25 Nov 2026 06:54:00 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Proofpoint-ORIG-GUID: zOzl4M7jOoRHrE5JQmizQI5xFq06nttT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxOSBTYWx0ZWRfXxVn59ioZKh8g
 +ptFoI82vKEoEMzbL2nBdOn7lsbPUuBZ9oC7lT13nLFSy5PEbJ+GyOBYGGRClwnKCmHHdpK8v6J
 nI0TxNlAzx4vDo4ygkepwrTdpdZUU8I=
X-Proofpoint-GUID: zOzl4M7jOoRHrE5JQmizQI5xFq06nttT
X-Authority-Analysis: v=2.4 cv=CKu/zhrD c=1 sm=1 tr=0 ts=6b0669eb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VUr37Z-sP6Vbzkouko0A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxOSBTYWx0ZWRfXyvJWaZvk16Mq
 43XHM3M/JGTTN24Ay2vcSiTwzdemv2uq0Ewg7lRgcHlnjA/gJhhdplsR8f7KrEEP16jjKGYs/FW
 82kLTVkKAYLVjpCLmQSo84QADViTtKwxnFczI+kOK6eE6lVbyUF3XIro0ALw8r1LTYYkc5juFxZ
 dPv7+KS9ACJRJoovjUmWFlfdUS5RSOpsrVJNqoGnS3a8vI5nkKnee5ukyCtAh7My3xeAbNRB89o
 QOC29swBH10TLdh2Kp+/UbnQvnxMf1aLRPYnWIIaStAvDXPTKv+gjbQkY8Vj0mn2HiKnt5hQknH
 JL/8iPADryAuOizSxuYS+1/C4oRgjappMaNWzuNtoxi0ro+GFo8PyacM409d3Z6O+q6887m/k90
 dbto+/TeZp4drSectcMBYD3y8R+d4uK9jBBvymafI76eXrH38B/OtHOibgbczIFFNkDXEgRHLNd
 /cLWQ2/Uk+dekbNLN3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250019
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 01 Aug 2025 16:51:08 +0300, Dmitry Baryshkov wrote:
> Drivers using drm_writeback_connector_init() / _with_encoder() don't
> perform cleanup in a manner similar to drmm_writeback_connector_init()
> (see drm_writeback_connector_cleanup()). Migrate all existing drivers
> to use drmm_writeback_connector_init(), drop
> drm_writeback_connector_init() and drm_writeback_connector::encoder
> (it's unused afterwards).
> 
> [...]

Applied to drm-misc-next, thanks!

[1/8] drm/amd/display: use drmm_writeback_connector_init()
      (no commit info)
[2/8] drm/komeda: use drmm_writeback_connector_init()
      (no commit info)
[3/8] drm/mali: use drmm_writeback_connector_init()
      (no commit info)
[4/8] drm/msm/dpu: use drmm_writeback_connector_init()
      (no commit info)
[5/8] drm/msm/dpu: use drmm_writeback_connector_init()
      (no commit info)
[6/8] drm/vc4: use drmm_writeback_connector_init()
      (no commit info)
[7/8] drm: writeback: drop excess connector initialization functions
      commit: 7bcb37603df095e56e87d6144201179fe911e4dd
[8/8] drm: writeback: rename drm_writeback_connector_init_with_encoder()
      commit: 81f61b4e0467ddab3695be58a94fc322c8bd559a

Best regards,
-- 
With best wishes
Dmitry


