Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9A606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ix68TqQC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B4810F6F0;
	Tue, 17 Nov 2026 13:28:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7781E10F6F0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pgk4Qd0GhYJ0WlbyQl7cozJzKhp0/3wkitfM0BBpn34=;
 b=ix68TqQCEgIyeZv7M6+fxHLArQWu58ct6CdY3XX1mriRG6psdoArXCI5ofBBNsEfmTqxdR
 NtlyA0wCQ86c8IDqaYfB1G/9RSUEnLXuBks94HFwjKsoH3huT5o2ATZsXyzX8grJNLmeMf
 YsTcZnrVsnxc7VrAS9BzJj4PgicuEZk=
X-MC-Rep: binary re single
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-Nn1SvXetM7qk3lUdHznLWw-1; Tue,
 17 Nov 2026 08:28:00 -0500
X-MC-Unique: Nn1SvXetM7qk3lUdHznLWw-1
X-Mimecast-MFC-AGG-ID: Nn1SvXetM7qk3lUdHznLWw_1794922079
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3C8E195608A; Tue, 17 Nov 2026 13:27:57 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 887AC1956087; Tue, 17 Nov 2026 13:27:54 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v7 0/3] cgroup: dmem: add selftest helper and coverage
Date: Tue, 17 Nov 2026 14:27:45 +0100
Message-Id: <20261117-kunit_cgroups-v7-0-5bcbfe17f323@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XP3UrEMBCG4VtZcmwlP5OZZI+8DxFp0mQbxHZJu
 0VZeu+mi1BND7+B54W5synkFCZ2Pt1ZDkua0jiUQU8n5vt2uIQmdWUzySVyJUzzcRvS/O4vebx
 dp4ai484GBC6IFXPNIaavR+/1rew+TfOYvx/5RWzX35KkqrSIhjeWhFOelG05f8mh69v52Y+fb
 EstcucgRc1l4c4hku6MBOsPXO1cc6i5KhxC6y13hNGKA4c/XNiaQ+ERvYxgTWwDHLjeOXGsuS4
 cPUhvSCtAc+C4c6MOv+PGlUNPaLU09I+v6/oDoy37ZuYBAAA=
X-Change-ID: 20260318-kunit_cgroups-7fb0b9e64017
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Maarten Lankhorst <dev@lankhorst.se>, 
 Natalie Vock <nat@pixelcluster.dev>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org, 
 R Nageswara Sastry <rnsastry@linux.ibm.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794922072; l=4451;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=J54cefq5pNs4CXyHrRneTBJTDa9pohFCkKAQn13xwl4=;
 b=XW1BcOhusZr1LLixs2v/qsL0BnNTojGLahXgKDyYC7ikOFNMK70fa2Nu8+6RdnCGhIvcEEM9g
 v8FJqQd2H2yAUyMfBGQ015Jilz/c0sIUchLmr+Zh9z2b01kqtSkkURD
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 3ZuqDcKqFKwjcNb_3yeiJgfWy5q2keqJ_k0ItLgVD04_1794922079
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

This small series adds practical test coverage for the dmem
cgroup controller.

The motivation came from following the recent dmem API discussion in
thread [1]. That discussion considered changing the dmem API and
adding a new knob. Currently there are no dedicated tests covering
dmem behaviour, which makes such changes riskier.

No reviews were received on the last version. The series is small
and self-contained, and was tested by R Nageswara Sastry, so
reviewing it should be cheap.

Adding selftests has an additional challenge: dmem charging paths
are driver-driven today, so regression testing is harder unless a
suitable driver is present in the test environment.

This series addresses that by adding:
- an out-of-tree dmem_selftest helper with alloc/free module parameters,
- KB() definition next to existing MB()/GB() helpers
- test_dmem for dmem.max enforcement and byte-accurate dmem.current

The goal is to make dmem behavior easier to validate when evolving the API
and implementation, while keeping tests deterministic and driver-independent.

Thanks.

[1] - https://lore.kernel.org/all/aZoHfloupKvF2oSu@fedora/

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Changes in v7:
- Rebased onto v7.4-rc3. No functional changes since v6.
- Link to v6: https://lore.kernel.org/r/20260831-kunit_cgroups-v6-0-63b6c7695287@redhat.com

Changes in v6:
- Drop virtme-ng wrappers
- Build the helper out of tree, drop CONFIG_DMEM_SELFTEST
- Rename charge/uncharge to alloc/free
- Add KB() in cgroup_util.h
- Use cg_read_key_long(), ARRAY_SIZE(), and KB()/MB() size literals
- Drop test_dmem_min/low
- Check dmem.current for exact equality
- stat() the helper once in main() instead of per-subtest
- Link to v5: https://lore.kernel.org/r/20260706-kunit_cgroups-v5-0-6c42c8753468@redhat.com

Changes in v5:
- Change parse_first_region() by find_selftest_region to scan
  dmem.capacity lines
- Use exact equality for limit readback, not values_close()
- Write VM tempfile to $SCRIPT_DIR
- Fix KTAP by dropping outer framing in test_dmem
- Use array for optional vng args to handle paths with spaces
- Respect O=/KBUILD_OUTPUT= when building, per bpf/vmtest.sh convention
- Link to v4: https://lore.kernel.org/r/20260519-kunit_cgroups-v4-0-f6c2f498fae4@redhat.com

Changes in v4:
- Fix charged_pool leak in dmem_selftest_init()
- Replace ssh-based VM approach in vmtest-dmem.sh with vng --exec
- Add main() wrapper to vmtest-dmem.sh
- Other small fixes suggested by Sashiko
- Link to v3: https://lore.kernel.org/r/20260504-kunit_cgroups-v3-0-4eac90b76f91@redhat.com

Changes in v3:
- Set charged flag on unexpected over-limit charge success.
- Add CONFIG_DMEM_SELFTEST=m to selftest config.
- Simplify -v to a boolean; single -v was a no-op.
- Unquote kernel_opt to avoid empty-string arg to vng.
- Document -b in usage() output.
- Link to v2: https://lore.kernel.org/r/20260421-kunit_cgroups-v2-0-bb6675d8249c@redhat.com

Changes in v2:
- Fix debugfs_create_dir() error check
- Fix module teardown race: call dmem_selftest_remove() before
  uncharging so debugfs files are torn down
- Use IS_ERR_OR_NULL() in selftest() sanity check
- Add CONFIG_CGROUP_DMEM=y to the cgroup selftest config
- Replace config-file parsing in check_guest_requirements() with
  a direct check of /sys/fs/cgroup/cgroup.controllers
- Add new patch 4 (from Eric Chanudet): vmtest-dmem.sh -b flag
  to configure and build a local kernel tree
- Link to v1: https://lore.kernel.org/r/20260327-kunit_cgroups-v1-0-971b3c739a00@redhat.com

---
Albert Esteve (3):
      selftests: cgroup: Add dmem_selftest helper module
      selftests: cgroup: Add KB() helper
      selftests: cgroup: Add dmem selftest coverage

 tools/testing/selftests/cgroup/.gitignore          |   1 +
 tools/testing/selftests/cgroup/Makefile            |   3 +
 tools/testing/selftests/cgroup/config              |   1 +
 .../selftests/cgroup/lib/include/cgroup_util.h     |   1 +
 tools/testing/selftests/cgroup/test_dmem.c         | 314 +++++++++++++++++++++
 .../testing/selftests/cgroup/test_modules/Makefile |  17 ++
 .../selftests/cgroup/test_modules/dmem_selftest.c  | 146 ++++++++++
 7 files changed, 483 insertions(+)
---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20260318-kunit_cgroups-7fb0b9e64017

Best regards,
--  
Albert Esteve <aesteve@redhat.com>

