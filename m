Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84FAC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2397410EA21;
	Mon, 13 Jul 2026 15:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YNV3mikJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZ3sk3Ke";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AAD10EA12
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF85b11887759
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=jCNdnjUhUKeZW3qBZTiUcs
 25NEdsz9x9Gc+pGcNEjQo=; b=YNV3mikJwG7gGRS4M12n9/zVqSrFD/JmyLx27Q
 VHqkwCWUfk8TgYeCE5WCokRZl7D5VeLhycUDgv3ZLubr4i9jig47W4mmd/sFsXEm
 LuGUVcvGrLQf8iPXeRCmPQ2r42vNznlrOAb7AJyYs10Tk/jmssPlVziuJVXWlKRw
 A/1IQ/Ytn8DqCajq67v6ob5pjPaJ35qvkha5wfFzd/l36jb9GWZ364lPhr2hnbF2
 5VKX73iyMojYulqgUQlHHhdNpmbL3CxQ01jpoE7sAVCYUj0xZRBUZDZsR6KHMIw0
 p3jFfW34D2U5tG9bVxXY6uc28vPpi8cFBfrSLDhvpPAxgTEQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwavscgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 15:12:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a23afcbso33781221cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783955538; x=1784560338;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jCNdnjUhUKeZW3qBZTiUcs25NEdsz9x9Gc+pGcNEjQo=;
 b=bZ3sk3KeMMmfCqpjVKNZhx1SfT62EK7vhJ9i2kG5bNti4/Jvo0QHB1EreekUhi4MVy
 tOJzO70nA0knluvUzQ0aME+P/qMGzNILhSkrduUFEpEIplx9QEYVBRamKhMduypgqnNz
 aj7yc22S48omQzHVn+EmrUPAlgwkATzsX6beHtXYfxPDZfSzYpFhEVu/f9MtgR07MjOx
 /8fAIN+gwjptWvekKfu7/1UNgIqI4kxdC+4FrnOBed7Xux2ufcbKS0FOyxq6/JE/JWwa
 L+k6j/BWfcGa83dTexbAciwL2QyZS4aTJ6/AhKUjV3midcmfr6U0TxieBxR+810ojBXI
 6tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783955538; x=1784560338;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jCNdnjUhUKeZW3qBZTiUcs25NEdsz9x9Gc+pGcNEjQo=;
 b=VxFY7PJVTkXo0mMphzQipblV+HJGgTeaXBrEBu64g01Eky882LI7CG6NMJsCKrhZvp
 /LOM7Lo7QPWngUvpOtJkNah60ZF/eOiEaq3E/qRqSn7g7J8utb18LXZlzSln8TNIMVmL
 +xI1fxw3PgcpegVMdF7I8zkxQnj8mMHU2sVWLR5s5FkySXugJDPce8YdyRJkMC/Xt9nh
 JGbPlagt1P1ZxkaAZAtgdAcru/V6sRyB37AS8Bq7YO76VnDwR/xS+rciSZBF4yUUfORX
 gbtUvrF8SYcy6dFxj4HiOeKOdHKt66ofbaiTHl5vqKW9ShFhulp5rlnQCGClf+y0lRIS
 Bf5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrY5dy8TN2zbSDiE9jDCZILWLEavWzNb8tdRJat5enFquR6R6rjEppRV96ZdCRsQro0O5V040zQYRw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKtAcMO3bTQG5eZs8Adr3LhH5ZBPENfxO9Ua03j9NFR40AfPdD
 fT0dTTHX8iDyB7HibU7ncebYmAr7Fdq+ZH30YA7hhEMZIYXGJ1TLa+1zKPrpe0GNSkalF1li+Dr
 26+1f+6C3noPcZKE9Waz+GEGPrr881XpmYVT8LsYHxjUDFJSC0b6/L5FbfsjkgfiWlAkKlqc=
X-Gm-Gg: AfdE7cmcrVu4+SlF3XPJfA9YphQ1qz0DJaJ8GubsiQvWE4kQjDYR5nRIBmiH8F7ULl0
 UsOBAhvmCYpPb90YbV8qTQYmP8PJLEda9ZraPwjCpjySOIh86vGcFoJTbT/MuQkVo+RUir59oFV
 kzVeD24xr7TXRk/jUsQN/e3VPk0QpMxjokBTjoeJ2P45dggAcEgukFklhuplIE9QzL8YXZpOEb1
 GMFpIA5NrE9EOGeiJRje4G30b4hpn68n5Tcc0iqprOeUb44GeLjo+B4q6lOo/Hq/7pnuCX1h99z
 kod18+z9pHAH84QN4GLjHwKPsMNUWX9vQrfLAgSxGSIeqPwKgldvcjHJ0CzHnD+ZjYUoJCAyBTL
 GeLZOeGZcluahVotfnbmqnAtW2BTditu4Tj/pLF6J
X-Received: by 2002:a05:622a:22a3:b0:51a:863a:a695 with SMTP id
 d75a77b69052e-51cbf210ab7mr84841311cf.50.1783955537810; 
 Mon, 13 Jul 2026 08:12:17 -0700 (PDT)
X-Received: by 2002:a05:622a:22a3:b0:51a:863a:a695 with SMTP id
 d75a77b69052e-51cbf210ab7mr84840431cf.50.1783955537058; 
 Mon, 13 Jul 2026 08:12:17 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a558easm87956664f8f.27.2026.07.13.08.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:12:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v7 0/4] driver core: unify the release path for dynamically
 allocated platform devices
Date: Mon, 13 Jul 2026 17:11:56 +0200
Message-Id: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0AVWoC/43SwW6DMAwG4Fepcl6qxCYEetp7TDsAdlq0Ai0pd
 FPVd18ATUVqQbsgmcNn59d/E57bkr3YbW6i5b70ZVOHwb5tRHHI6j3LksIsQEGsIq2kv9YNsWy
 5anqWTS2Je9nVLe9lBLkrohwwzxIRgFPLrvwe8Y/PMB9Kf2nan3FXr4e//2J7LZUsyBIq45Bye
 G+835677Fg0VbUNHzHoPcxEwFURgqjYgMaCGJgWRJyLyaqIQTSIORVW5wC8IEYzEddfHQ03amM
 jylTGhAuieYhGw6poBlGhYediTPRSjvFcXM8xDqJLC5OkmJID+0K8T0Vo+dyFcl2mNoiKvc/Gc
 u024yarYnkaZPe3zk2haucUJIxobfrMB/yZehztrsO1x7L+mvKkyAExg80ofXXr/RcJ60m7EAM
 AAA==
X-Change-ID: 20260410-swnode-remove-on-dev-unreg-42bfc4b23ba8
To: Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: brgl@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5549;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=SN6yJVlt1OqM5Z99tFYmTGC+sK1cATMS2cnJAx/jZqg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVQBFWX74oehqak5Vl2gkTFUTo6fnHjCHHQr3E
 wNARin48EyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalUARQAKCRAFnS7L/zaE
 wzy6D/9et40Mp87suZFlhmfZoHux/5PMs/cV2uqMIgtXJRTVd96XYZ3zLScWIjqNns5QuXeAPLD
 vDV+iwutxTNy47NzuS9wy5a9PZu9qYgw7zxQcrQa81LCIVidRKnHpClsBY3F9lQe+4QSpvOHUUV
 IaMHqELDNxoV+06HdzDIcKxcBGlqb4r5v1iQ9VOebZx+PLw7osnk7RtQHrlovL5QXfy7A7xrGEU
 KGvx9wc+Bb0n1sJM+b3dWVYgTVeh4SKqM9Y9KuE8lLu1ntXrU19VYVVOvST97rSho1kWWldgLM0
 GJz0eiJX3XyaI42ag9WLH8HNBFbvXVHvaJDr6QxdrinYsES5hoJxa6I4Rqai0yMGua9YG+7RCfd
 Uw2AQO3I2xqwJ4EQJWTJziMd5qNbGlA1wte4G2PlP3+wpJNOBenhA0GKS38VzQvDomvgfwOiBR8
 +WHLZIpuzTy56krLi0OTcrlNno4HHm1KXMwZadPK2Wy3SoNi2/BTkXuEc21Djv/vjTHbdSBlrm3
 H2mCFdxm94pKZ4TGxQoaWKDTEQiYVm+TVtWATzdoQ2zqO40toLkPnvfdiSqmeYEvGFy5i2ebR87
 JDQN2IEUuT06lPM+PdW56g7qQO4kYpIXg7Ar/2jUmMbUZgE1ZAue8Q72aldup7lPSSnv19noQJK
 tXvN4htwWfv4Irw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: X4atsG6f4DSWKhqsPgCR5YoQ1TW9eRC6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfX9eV9pnWnHpP6
 ROHQSBM+ikKTGO7Gunli/qAYCtIqmrtu/4av4vLBJ9YTevI5gcJxcVQ9rHC7sWNLXqt9buWcIee
 pdfn3yDOq5bPVGHlBvoKEORxAcwBhA9YkUj0Q5zE/wfsrjDdzrqLAD2j3bBd6dTsnN3GXsWQ439
 QNLtDS+pex8yw8x8gWjmotwv9HNbQpyx81C8GwT9BIYGNPvFngv5ei7Ku+fnOFvRUr1T3u3+qR8
 dIIekc+cZ+QsWsD/GT9Jd+bkOSXAt09+ChS9yI/Dwd0ejSj6+F16CqOm1n+ofXd5WZQ6cTBHgUp
 zOr34ZTF0MQBDQYTKX6iJ6Fuy4ysGsMTFcu9cJH4jWOsfBNmfzUUkAYzL9CfORar4WkH8HvQPWa
 YUnFg6e3rFUaZ3VzVJxag5mKY/FUVUuOUtdQwmzlGryp7dWljDQZB9yBfw1MzlM1HDW4Wjvjmom
 aC5khd0vMaeV/uixZbg==
X-Proofpoint-ORIG-GUID: X4atsG6f4DSWKhqsPgCR5YoQ1TW9eRC6
X-Authority-Analysis: v=2.4 cv=dZSwG3Xe c=1 sm=1 tr=0 ts=6a550053 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=fY9noNvUkyJ7C7eDhOYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfXwY0IC4X6rSGu
 rs1SdXBxEhLynkojBMCp6DKJ6FkAX0vDYH180bh8aypKvllCrndBXtxWpj0dS5xqo1mzt3LwoVq
 MSsgT6X/sNru/fxH/IGvaOY9en53LAA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130158
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

This is a follow-up to the fix in platform device code that introduced
platform_device_release_full(). With the two prerequisite patch series
applied and with the two last remaining offenders converted, we can
finally unify the release path for platform devices using
platform_device_register_full() as well as those using the split
approach of platform_device_alloc() + platform_device_add().

With an ack from DRM and platform maintainers, this can go through the
driver core tree.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v7:
- Drop patch 1/6 as it's already upstream
- Drop patch 5/6 as its been replaced by another changeset sent upstream
- Lock device when calling device_is_bound() in kunit tests
- Fix invalid reference put of the firmware node in surface_gpe
- Rebase on top of recent driver core changes
- Link to v6: https://patch.msgid.link/20260513-swnode-remove-on-dev-unreg-v6-0-f9c58939df27@oss.qualcomm.com

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
Bartosz Golaszewski (4):
      platform/surface: gpe: use platform_device_register_full()
      drm/xe/i2c: use device_create_managed_software_node()
      driver core: platform: unify release path
      driver core: platform: tests: add test cases for correct swnode removal

 drivers/base/platform.c                  |  19 ++--
 drivers/base/test/platform-device-test.c | 180 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_i2c.c              |  22 ++--
 drivers/gpu/drm/xe/xe_i2c.h              |   1 -
 drivers/platform/surface/surface_gpe.c   |  39 ++-----
 5 files changed, 210 insertions(+), 51 deletions(-)
---
base-commit: 28a74302c6acf69768804a279eeb9eb2d9124956
change-id: 20260410-swnode-remove-on-dev-unreg-42bfc4b23ba8
prerequisite-message-id: 20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com
prerequisite-patch-id: 76dea1205a0905915a03c0d7c9e94399c92501e5
prerequisite-patch-id: f6c074c48e5eb2f5e92c57fa1320b6b0fab3ce1d
prerequisite-patch-id: 07a0c422cc3233e2fe87cb9bbd6baab608d0de82
prerequisite-patch-id: 5e980cccbfdc82adef1573f8a8a9639689836432
prerequisite-patch-id: bb193e0baf41714061b83b3925cc4e28036f2b9c
prerequisite-patch-id: 5ff0ac2c7c4cc548692ed5f567db30e27e920786
prerequisite-patch-id: deb425beb85441169aad53c1282f35df513b8015
prerequisite-patch-id: b0e9e719c8daf30d97c110478a5c3c7af106472c
prerequisite-patch-id: 9f118a7cdb92893ed4e913c7c98bbdb766ff18c4
prerequisite-patch-id: 1b2391d8295e80086182f55e5189b9aa588687f8
prerequisite-patch-id: 986a0f4f9a682a255f6eef0fe2128a86c595ece5
prerequisite-patch-id: aae63ceb82cbe6f65810751e596e542df0ff513b
prerequisite-patch-id: 155601719d4f5c433fd7dce63842007f255bec81
prerequisite-patch-id: f9bebca5cd8f5ebf9b52e9c688a3c83ddc7efb7f
prerequisite-patch-id: aff2299bcf258e4e6dd1f01c591141385f31fdff
prerequisite-patch-id: 51cfbca3ab011688be133a259d598007289237c4
prerequisite-patch-id: 0e9bddaa83a1f5a99745c2f50f7c3213d7b17fbd
prerequisite-patch-id: 7ca12b7bbf0168eadaece00587dad68e1ff3cbec
prerequisite-patch-id: 8d483c4b391ed1b95897c951555e7ab6c5807e2a
prerequisite-patch-id: 495173352a585bdfd0c58721c8be0558d06a5335
prerequisite-message-id: 20260713-swnode-fw-devlink-v4-0-d4f2dee27ad9@oss.qualcomm.com
prerequisite-patch-id: d7f936bb1eb8e9fdc0a6a35770e376d36a0b595e
prerequisite-patch-id: 77b6a4eb67cd6bcb6fbc974a4d0368be6a2810ef
prerequisite-patch-id: 744bdc8ea502dab2db13b1cbe963c1db49c951f0
prerequisite-patch-id: 185deea7fe874a7d4a70c93e0b60cc3bbc75ec25
prerequisite-patch-id: d9e41fb8f4070e53ac293db82ccbad83c8d2a40b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

