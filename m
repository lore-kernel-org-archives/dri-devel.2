Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08086CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2A710E049;
	Tue, 12 May 2026 11:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MeprPw79";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YPnxkKYz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD58710E049
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CAo2ur2518442
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3neawzxRuWoJiguAZtl2rO
 1U5dIQZaPDLZpbfcRIhj8=; b=MeprPw791zFDSZDkXkrnYgN8hAi+1yvykZs6yg
 p3ah7WWeZSs0NpgxcL5qjOoU4t5ZPnlmLuBjjhPUkuhIxpuzPfnJOp1niXGVUYgB
 0Vs0ZjnvytQrgBD4UhvRq+ixovFmXFGDqckcK623t2QpSKizfzzCNJeaF8UYuGtb
 uw+udkDsxrAJjQMb6Pol6zZXBHR2DXD8qeiC4zE4ZQXLcn/vHrjP+cCwjTD4tASY
 ChBu5iv1ftBhk6FwPrKzqheJtq/KImKlg3/WsFDAEBxtoFBn6wLwp+PxRpXmWywg
 FxM0eykpG0iQLOjXzjT545l+sLBM/PrpGVdCq2wJ2Lzvd2Gg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1k65e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:59:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e136aff17so93543061cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778587192; x=1779191992;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3neawzxRuWoJiguAZtl2rO1U5dIQZaPDLZpbfcRIhj8=;
 b=YPnxkKYz6bZ/d/PWuQq5Yc9v+A+2UwDoF6IEbvLAa9jytHrEIPA4f4V/O8iwgHKW7J
 oSTbm1JD+OVUelRso+jAk2gdkrDfySBbyzwkwdf4xFmOOU41B0U8XBG0jSIljFeCA0jz
 vbYMik8hT2ehorJJiRpmp6+4Nvc8/2Hvk9VE3PcSwwNzcBNTHC2/7RwbVCJNPfgOX/FE
 gNaTBHsaqhcl0rKTyT4/ofJz/PsplPNnEsHxRpjeLtJJXTV/m8oxAHlpFoT2XHY79Ooz
 EISw1vUHJ54yKFkMkf5QJzY73V1YxGBpIO+c3r23nWOwjQshpDH917E/7OqlDBf9H2Vh
 6kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778587192; x=1779191992;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3neawzxRuWoJiguAZtl2rO1U5dIQZaPDLZpbfcRIhj8=;
 b=Ym/nAW2J8nlj27olR0EKbt/7JA16l90Bh8YqeufXSCLc6DqNSF3k3IA4ewvAc7zUdW
 EE+5N/e1sZgvEY702xdR/Bz6I5tPj7AGQqUTh/kQsQLTkeqEorzvRbKj+pVVJ1czT0lF
 ralJDUdRLslKzOJqZ9Qhr3TNRpZj27nBWHmVsgGhPmucYmRtqgIaZNeObOh+VHiNWWIe
 GFj+JDBMfBUYaoyN3mp7mEj1r0kVByDGlkqiKyEOIG8hjTM0EEK9LeK5kNmcS3weV/WZ
 vrCC5V9ycf8+BHXsLGsKS2Z0LUEWp4jd22/6MngoiNFvRDb0+NFVHrB/cDxTPY5K7uV+
 hOQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HVYR95BrH4JZpOVc0AMrQf2QS18lSxwxbzNEHWk1shyAoX8Nw0vGVFu6ZgdIgKwa/+F08N7hDveE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxH7J7gXYkvbJKNDfJWwrn32zn6Hp1EuDSSlTJwn95LqDXUcK90
 VXlKd+BrKwKAGldOVQJWciOyWeEv+cCqutK29YrfNu3OBK6mRPah1apwCaI+XqdIGutYK1B2eD6
 MSGNw604lQfRQtI1MgSP/s1kiAx7Cmjx0WTpGtPADthva+Vw+XNd/663cKhtgY1cw2a26k68=
X-Gm-Gg: Acq92OE96Vnl9WI57nj38+fBNqc/OlvNF/S3IfaMl8hB+7Y9Qcxx0LgYipUmmwzjzu8
 3mkbb+e8PKSkDkhzuZk2Xbf3NLezJcLYB4IuCH85zVFHbl7r5GzJICLm3hCswRi4KiLBS71pZSx
 fXlZYWjOg9B35IfjALw+mJ7JXW4r3/qXGn3HoLJu3939aMKH8Xb7nfN241IROBhAdt+zsNrwOcl
 FPj4J8uPjXBCCVf6IsCCcs6Q8uKs1aKXFzRi9FRoBhwwP/ZcdyMC8QMhdvQVhoq8PcVx2I5QMqR
 KSD66zgyvtf+oBAyjd6ir6SNjxlr095F+laAXWDro/9haZDFzsQ5vGnJj8FVE7MdVkJYzEDauYx
 ++Yc5JHKPV4H1sLJS4KivSnEwPKtBhxJhpJg57wvOh5a3mfPG+Zk=
X-Received: by 2002:a05:622a:199a:b0:50b:2eee:4b38 with SMTP id
 d75a77b69052e-514619de95emr397544971cf.8.1778587191940; 
 Tue, 12 May 2026 04:59:51 -0700 (PDT)
X-Received: by 2002:a05:622a:199a:b0:50b:2eee:4b38 with SMTP id
 d75a77b69052e-514619de95emr397544511cf.8.1778587191457; 
 Tue, 12 May 2026 04:59:51 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:74a7:1c82:3f14:b431])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9067811dsm73933355e9.9.2026.05.12.04.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:59:50 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v5 0/7] driver core: remove software node from platform
 devices on device release
Date: Tue, 12 May 2026 13:59:22 +0200
Message-Id: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoWA2oC/43PsW4DIQwG4FeJmEsENvSiTn2PqgNgX4LUgxYak
 iq6dy+X6Ybm1MXS7+H77ZuoXCJX8bK7icIt1phTD/ZpJ8LJpSPLSD0LUPCsjFayXlImloWn3Fj
 mJImbPKfCR2nAj8F4QO8OogOfhcd4veNv7z2fYv3O5efe1fSy/RfbtFQy0ECo7Ijk4TXXuv86u
 4+Qp2nfh1j0BisRcFOELiq2oDEQA9MDEdfiYVPELlpET2HQHoAfiGYl4vbXZrlR28GQU44J/xD
 nef4FFJbieMEBAAA=
X-Change-ID: 20260410-swnode-remove-on-dev-unreg-42bfc4b23ba8
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3503;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=RgA2s/ETiOsSC/3tONU50v90I3+p2ImRh+ak2kO9UFU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqAxYnbnSB8uRw3SqZx+7HL9YftDRf2Hmavqm77
 0qwC5oVHaCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagMWJwAKCRAFnS7L/zaE
 wxghEACowF1Mkl+w1sNCuuqh+NdmCs1NUavW4nlxm3wgGBZAAFJ8ZgwcWUe2rPCdwhTljkV8G05
 cYP5RwR1c97BjKXb+aSKMTOBS+xCKCw0LZp4j1kP6GqehfgMcRgVeqlvuG8MsMluEQCrssOmxJt
 PV9sPTtRVjCWIZqeEatN9V/3xT8qSwWs2uK0jyitb1xSmgV7/cjnjrEAdQAe9PuZtgpoZc+03Td
 x2SVw6/ZVG3duDEte5pBHE0yHYy7nFwEdkXfmSh1hEGiAAVHPWmZiW/hD6OWWpImba6gl4V8SEO
 8VDUC3UoPQiJj2F1b8lMxVHN/Te/xczH/u9A/OtU4KZKLeYf4H2N6h4Wokd50hE+gEKUxBHQKZ0
 lBoCkfWsIIy215PHedxu4RZo4L3eA0aLE8u+v/HKAyEoT8YceSX2qsM3uLv4F51CbJaTnLSS9Eu
 x3HNVAfVPpdYiqa1NMlAa5z66FM5OKeVsQVoH6qYNqph44vJIl/D46zsEx3CIAjIwhCegTFk98R
 xnR5HwFwBiInYWcfkDdyMZBF5DCWM85bs65Sd8Q9lQzoVISrZfoUV22rpXAW3AtmF9HJEzt40Q7
 zYW7nc9b/vxJ04kKY+e868muDM3PKHe/MtL1dCcn6l2LDqGFzcJD+S1zwFZwEsU5k3O15kSLFcQ
 q8BoUymNuBisTfA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: BIweOFvybFprN6mNc5rXlc9od4a3RlcR
X-Proofpoint-ORIG-GUID: BIweOFvybFprN6mNc5rXlc9od4a3RlcR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNCBTYWx0ZWRfX+zKKF892eexe
 +wm8WqTf3R3aeY8wFoZ2mHolUg+ReFyC+AkFw3m9592UMJCPNPX8VCsY5Y0f74rGUcMCM6929Nj
 0dtDCaAcflizPAAfVNYrK6PnjIDgBeqPTkzSECkodlalPtVso3a7a8MxtCFkKN9IXyMbw8g/o6p
 3Ihcr7+9tH9VLbJ0AIDCWcsHINiWJy+FrC62uhNII7y351u5t9xtEatt77xK39SXrz2RgdMy2na
 WQ+yamwS5lgN1SEWt1DVUbGHnrK/p5p72mP8HfQDTW/Vewf2r8uBKBAKOf1c3eeGFWA0m2bai9A
 AZ90gsiavxUjROlWNxDyEe/ufcH/MMpTstKQYmpY8skktLkLJafczKuKchzlw3GEKTBoR3lTt5I
 LkzyrUWvtyMJzBCHvE9U6+s7tEyjbz6lZs46PhuiS0TEuFxHXgfBVW5v430Fed5UAtdGrhobyGe
 73qREoCZdKwdF30sPIQ==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a031638 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=pOVGAA1bDAHTFGk8ZFsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120124
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

This fixes an issue in platform device code where, if we specify a
software node for a platform device using struct platform_device_info,
it will not be removed on device .release().

This is an extended approach from v4 where we also first introduce
necessary changes in drivers where the fix may cause a regression.

Merging strategy: Danilo suggested that the new interface we add in this
series as well as prerequisite driver changes can still land in v7.1 so I
think the entire series should go upstream through the driver core. The first
5 patches are part of the fix and the remaining two add tests which
can't really do harm.

DRM and platform maintainers: please Ack the two driver patches in this
series.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v5:
- Provide a helper for users of platform_device_alloc() that wish to
  assign a software node to a platform device
- Rework drivers that could regress after the swnode leak fix
- Split the series into several patches as necessary
- Link to v4: https://patch.msgid.link/20260430-swnode-remove-on-dev-unreg-v4-0-01574da0aed3@oss.qualcomm.com

Changes in v4:
- Drop redundant !pdevinfo->swnode check in
  platform_device_register_full()
- Handle all three combinations with which two software nodes can be
  assigned to a platform device
- Extend the new kunit test to verify all three combinations
- Link to v3: https://patch.msgid.link/20260428-swnode-remove-on-dev-unreg-v3-0-533bdc71b22e@oss.qualcomm.com

Changes in v3:
- Make sure the reference of the primary software node we possibly take,
  is always released by moving the get() before calls that may fail
- Don't allow passing two software nodes
- Add a test case for that situation
- Link to v2: https://patch.msgid.link/20260423-swnode-remove-on-dev-unreg-v2-0-0e5213cde2ed@oss.qualcomm.com

Changes in v2:
- Change the order between removing the software node and dropping the
  reference to the device's OF node
- Address a situation where a software node is used as the primary
  firmware node
- Add a patch adding a new kunit helper
- Add another test case
- Link to v1: https://patch.msgid.link/20260410-swnode-remove-on-dev-unreg-v1-0-cd7d305f3db2@oss.qualcomm.com

---
Bartosz Golaszewski (7):
      platform/surface: gpe: use platform_device_register_full()
      driver core: platform: make the swnode check stricter
      driver core: platform: provide platform_device_add_software_node()
      drm/xe/i2c: use platform_device_add_software_node()
      driver core: platform: remove software node on release()
      kunit: provide kunit_software_node_register()
      driver core: platform: tests: add test cases for correct swnode removal

 drivers/base/platform.c                  |  44 +++++++-
 drivers/base/test/platform-device-test.c | 168 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_i2c.c              |  21 ++--
 drivers/platform/surface/surface_gpe.c   |  36 ++-----
 include/kunit/fwnode.h                   |  19 ++++
 include/linux/platform_device.h          |   3 +
 lib/kunit/Makefile                       |   3 +-
 lib/kunit/fwnode.c                       |  52 ++++++++++
 8 files changed, 307 insertions(+), 39 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260410-swnode-remove-on-dev-unreg-42bfc4b23ba8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

