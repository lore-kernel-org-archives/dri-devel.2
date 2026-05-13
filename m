Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFB3CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 15:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F71A10E2C1;
	Wed, 13 May 2026 15:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S24A/8Qm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TlWborfa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3539B10EF04
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DC4gX53324691
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7G74dft31Lo1+haHnmSpHq
 lZXb5mdDLiyXN6E5wj57U=; b=S24A/8Qmzcan0EorjYsERpeGgy3QqFCNAZ6rcn
 OIEJ9AyKQUTmmSsBVcUwkqpyk5qws30lN6EzaoSqkeDcfFyVKPpQuLOwJhzFV6de
 IbGgFT4gh6Rqwyg0RjrYFvHl1CuH3iDzVX0FdzfMzX/KKxrLvVBu0JKK5VwyKVvk
 vSjgZydzClcn/v4m+m/QFmLAw81c0R1OYZ8sU+bHFWmd0xqDf5m6GLnZ3BJdreTc
 HhGihtm/FCv8QI5/lWDjeXbusA2Ty9EHinaSW9OE5NigeYz/5/TANRRPaYYf2mHD
 vZXHuXJRGGfUAiKQk+KM+3N/XhfBze6iE+QS7xv9FfLUHLRA==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvda2kn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 15:05:19 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6853c2438b9so12174728eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778684718; x=1779289518;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7G74dft31Lo1+haHnmSpHqlZXb5mdDLiyXN6E5wj57U=;
 b=TlWborfasGr5LLdy+XsmSOk72LM7ko2nVd7l+0/79EIOBgB1RCBVxMUdTTgRn/r1iB
 jxVZV0ttRK2Gl0UusHME4Q9gctegtyYAKW2BmjnZV7aAg/ew4cLT8R4PhhVS/yzqrNjM
 wm/jpYsaHPUBint3WUgqGL/iCSknUTV+FPWydyulhINnzdsusYOYM+um/txtHz3mwnNd
 T36xKy2DbryKCmF0cVj4pBToJOCRewdLuEKM8mtCrYX1+Qvg5eH1IohShf1F2xz7fASo
 jOUAczR29uWWpZ4ewGw22w8D2YCPvl4be5QovW+WYDZTEI7K/BxNUAIvgFdIU/JpWYzk
 bxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778684718; x=1779289518;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7G74dft31Lo1+haHnmSpHqlZXb5mdDLiyXN6E5wj57U=;
 b=AZQLQyIervVY0VQ79OV58nrWjnrNH559TC24VBWYAsNSruspvsUZWc9N0EqsgjezyF
 mynAgEA+ijTEBwnlDGJUcPRmBrk0Ai24OsWls5mBVAOpbWvdpm4/3+SQjz/2BcVBRlff
 0QtKVNctRjO4VqhlVV9DFVrF57cCtxxguCONwVjOXf1ie/1LhbfciD4kopd47iLONSIt
 A8eO26Q4TtaJcacbGrsZ7kSGPevjNPpU7w7eAMfeuKz8U4TyTylFxHzXHq8gwYlitJZS
 YNpPhp+Hrz0AsgsdeIBRxXZcgQh6oupVXT3OCfRvRyYhwvksrZzNBnOOL5CMGj6qDlx9
 dG8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9763VWkfROZMaFKbkhlyV28wDEv/TiqPUBhPyxe4Nz4CYfVkH421wL09oC2Btrt6h9Wqm1TmUVsfU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNMQ2o7O4iKDP1w9FePJTbPFanHBx3OqTAH34fdwKaY0M/X1GW
 7IXpIhAN3Y6ta/kENHb2ZMKbsnbFQ2kOcsUNm1V8fGHlQBKF8QtViC66cIhVcOCKuyYIgsRzAVX
 6rUzMjsYwszSW5DDqAszXwW1hojnfV+oKwANQ3XE5sPwUrDQnkOjqCibEWZeIAtfngOnpNgk=
X-Gm-Gg: Acq92OE3BKiW+63UDvPk36slOfDudkRVti2eztQai5VeywdajowWhxy2A19RQBFQ6cz
 5yLTU5gh+yu0p+E6H9Tqv70d6MJBTb1BAKPwdqLMPawqw6WQgElMSCyGogsuefy4jfTqpV/ZW/c
 py4/4fW+D+VTqR0Ul0A8EOyMrLp2Kj5NEF0cudVK2kIhB8hqMXVq9g9r3oNc0yWdyDUFPWXOMN4
 Ziq2OCXU95wfMhUx+8BkBjcaXEcENUVhffRpX2JRlZ/xXqKMHFxXHfg/oq9XalePLByg1NGYcmi
 MjHP6qZSN24k8BQ0C3huyTLVM9beZCZBRS8AUeezLrCkipRUGEu1JtWv+bEUrYYz4XvDiVf7Gha
 EQ6lPaDwKvYWBnJenJm/7knv08FrWBQTx9XS8setHDVeK24a5xQ==
X-Received: by 2002:a05:6820:2914:b0:694:a02f:75ad with SMTP id
 006d021491bc7-69b78e78ddbmr2196253eaf.59.1778684718469; 
 Wed, 13 May 2026 08:05:18 -0700 (PDT)
X-Received: by 2002:a05:6820:2914:b0:694:a02f:75ad with SMTP id
 006d021491bc7-69b78e78ddbmr2196188eaf.59.1778684717795; 
 Wed, 13 May 2026 08:05:17 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:63ec:4acc:c4f6:423])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f542e56sm43216455e9.34.2026.05.13.08.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 08:05:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v6 0/6] driver core: remove software node from platform
 devices on device release
Date: Wed, 13 May 2026 17:04:47 +0200
Message-Id: <20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCTBGoC/43QzU7DMAwH8FeZciZTYidtxYn3QBya2N0i0QYSl
 g1NfXfSXeiBVlws/X34+eMuMqfAWTwf7iJxCTnEqYbm6SD8uZ9OLAPVLEBBo4xWMl+nSCwTj7G
 wjJMkLvIyJT5JA27wxgG6vhMV+Eg8hNsDf32r+RzyV0zfj1lFL91/sUVLJT21hMoOSA5eYs7Hz
 0v/7uM4HmsRi15gJQLuilBFxRY0emJg2hBxLXa7IlbRIjryrXYAvCGalYj7V5tlR21bQ73qmXB
 DtL+i1bAr2kVUaHkYGuz0X3+c5/kHM8CRkxMCAAA=
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
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3789;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=0V71TtYcYEciG9iq1qyh+HCEIwd3+5DXRbbrqXQ54qs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqBJMf0AQ5uwUBUI7xyN99CXF/d1xvwkayzkzbY
 U+f7MKCbBWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagSTHwAKCRAFnS7L/zaE
 w4wVD/4qIYDdscO1r9fZg7OMg4AxykbTGMhI8QAx5HQ9Nag2ozqAmn4UL5llwqMtW3WykfL/xxM
 JoKniDCBR28q8omg6PKuq2jhQnu2SduVxUa+N9zFlCm0VM/Gi2cnJ+JNsgX2XNXsckiqQcNMR8e
 pSpPAfQXLGJwva0x+V12SIkxJ3oVYOhhVNSr9/cUPyZTlvTSEqIN6OJLHrJbOoQfL/Nz7+L93oL
 UdoRZbK4855dX0SKR88YanH9xq7hJaFxYDJ+Ha2qM8Fi6ZScIkCqTaU3ez5dE14iS5HpdxnHkNu
 rtt0+HI3hoEHHQEzWbVDjHmyhwF6nz0pvd4y8UVIlGdDLEkGxue7V33n9PrAMlNOOwjUqF7jYqx
 dlEkG+Bgoyf6SyBdiLZxB7Nzl9zt9DlltvjFuMt019Y796DbS5zqRo5QlnXcxWFVOKf/kkfeIOl
 kMEU642tLKmpN6QWZxylQOqa/3W5AVpXwAZiZACbdzxJXOvAe2X84qLprOCG0VlaGzvUAlgUi8e
 c+LsXIvkdO6w1o73laxmTU9yqWDH/5ScSKEYRagXDFglXsHaG0AcavLbmcYoD/c3JcK5RQPgenn
 M2Wjq9AvbcaJu8po9jrCbdxHqV2FMb9RYEFIS+sKbvzMjmDbO7iuXVHUqXwDjPOFJbUqINmqh9A
 KItTVFjyUybEwbg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: tLro07FiUgaZfNfz7n8GklBukMSu_EZA
X-Proofpoint-ORIG-GUID: tLro07FiUgaZfNfz7n8GklBukMSu_EZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1NCBTYWx0ZWRfXwu1qmDhjDKRk
 vwCYZJI/yigxWpZ7a1zBsGwGvf0jHCK9mkuTf9V9U5948M2Ih80bPNX0LtaTYPcCpf7jEuOA6Le
 2RTMhTynVz2BUbywACiiQUDnkIu+Ur4kj3kxqjgZa/9cNQYC+x5gE1WWQEfZJDas9QumNck4xzy
 k21vsBTAgx9n7e69qRVW1lJ/pPgksO0S45cAUYW4lq9rayMyYe1cOJONcBNabmOcLWKYLIj6jx2
 E+g5P26jevvYakRFG/Bxmy+LQK8ecXeqHvJOJpcPauEyiVTlRIjYG7s7rSVfqF+wTHbYcF0YcWR
 MbsxAhvPT38WUBTqkZfem+2nfC8zeo02pYgUPIevYA6OBiQUVw4DugpUSSxDd9XOqC3Q96YiP9m
 a11V+wTkBSnob94WEU/LFtRRlWWbE8bYOUIeWg70uIB+Y/daQHJH/uG3duW3N6+07Iq9Qi8sHB4
 CZ32+Km35uzm3pqSMqw==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04932f cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=pY5QAryt2IY3wJuL2WEA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130154
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

In this approach we first provide a fix to an existing problem in v7.1
which requires a specialized release() variant, then address issues in
drivers where a unified approach would cause a regression and then merge
the two release() callbacks into one.

Merging strategy: patch 1 is a self-contained fix and should land in
v7.1. The rest of the commits can wait until patch 1 is upstream.

DRM and platform maintainers: please Ack the two driver patches in this
series.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v6:
- Make patch 1 a minimal fix that can go into v7.1
- Don't provide platform_device_add_software_node(), instead: rework
  drivers in question to use other existing interfaces instead
- Fix life-time issues in the xe_i2c patch and remove unneeded fwnode
  removal
- Fix typos and tweak commit messages
- Link to v5: https://patch.msgid.link/20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com

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
Bartosz Golaszewski (6):
      driver core: platform: remove software node on release()
      platform/surface: gpe: use platform_device_register_full()
      drm/xe/i2c: use device_create_managed_software_node()
      driver core: platform: unify release path
      kunit: provide kunit_software_node_register()
      driver core: platform: tests: add test cases for correct swnode removal

 drivers/base/platform.c                  |  19 +++-
 drivers/base/test/platform-device-test.c | 166 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_i2c.c              |  22 ++--
 drivers/gpu/drm/xe/xe_i2c.h              |   1 -
 drivers/platform/surface/surface_gpe.c   |  36 ++-----
 include/kunit/fwnode.h                   |  19 ++++
 lib/kunit/Makefile                       |   3 +-
 lib/kunit/fwnode.c                       |  52 ++++++++++
 8 files changed, 276 insertions(+), 42 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260410-swnode-remove-on-dev-unreg-42bfc4b23ba8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

