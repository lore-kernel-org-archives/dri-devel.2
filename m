Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B721C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F3810E7C6;
	Mon,  6 Jul 2026 07:13:31 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
 by gabe.freedesktop.org (Postfix) with ESMTP id 665E810E2F3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 06:19:59 +0000 (UTC)
X-AuditID: a67dfc5b-c45ff70000001609-d3-6a4b490581ab
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: max.byungchul.park@gmail.com, kernel_team@skhynix.com,
 torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
 linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
 joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
 duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
 willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
 gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
 hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
 jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, boqun.feng@gmail.com,
 longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com,
 yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com,
 her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 sumit.semwal@linaro.org, gustavo@padovan.org, christian.koenig@amd.com,
 andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
 samitolvanen@google.com, paulmck@kernel.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, josh@joshtriplett.org,
 urezki@gmail.com, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, kees@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, mark.rutland@arm.com,
 ada.coupriediaz@arm.com, kristina.martsenko@arm.com,
 wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com,
 dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com,
 yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com,
 joel.granados@kernel.org, richard.weiyang@gmail.com,
 geert+renesas@glider.be, tim.c.chen@linux.intel.com, linux@treblig.org,
 alexander.shishkin@linux.intel.com, lillian@star-ark.net,
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com,
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org,
 brauner@kernel.org, thomas.weissschuh@linutronix.de, oleg@redhat.com,
 mjguzik@gmail.com, andrii@kernel.org, wangfushuai@baidu.com,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-i2c@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rcu@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 2407018371@qq.com, dakr@kernel.org, miguel.ojeda.sandonis@gmail.com,
 neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com,
 dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: [PATCH v19 30/40] dept: make dept stop from working on
 debug_locks_off()
Date: Mon,  6 Jul 2026 15:19:18 +0900
Message-Id: <20260706061928.66713-31-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0xTZxgGcL5z+U5bLTmpJh4xC1plcxqcW4C88bJoJPFTTNToLtliZjNO
 RhGKKYqiYVYYhgEq1lC1BS2XNh0WJa3Oy+ymBIooDSIKVVCsARQRMUjbFewcl/jfL8/z5vnr
 ldAKLxslUWv2iFqNKk2JZYxsaGZFLLchKXW55QWGgvxDUHbRjiFsusLB7c5cBnr8BQiC4yYa
 wno3B6OhLg4MbXoaSn29GIatxQiM/SYOBhrXw1DPXyx0Bl4jsPb+R0HYsAvOVToxDBreYhj3
 tNJwqvQeggrfExouuZ8icNlyMfSVXKahvTcSHviHMQy1lVHwpg6DOdfFQlvLIIJykx6BodzB
 QLdBT0GPtZ+BUwMYQtYaDqy6GDB52ll4bjNy8MGcAe7zLzhoftrBQk/TERau6J5x4HjUiGD0
 gY8Ce3E/Da7HS6HiSDUDN1zNDBSERxG4rz6noP16GYbiusss6ExBFu66bzPQbPyDgS7PcQ4s
 nW0U+J55WXB6WmjwlvQhqH1TidckkxrnnxTJvx/GxH7Wjsj4mB6RUUseTSx3X2My5n+IiStg
 ZsidSoFU/z5GkROeWHLN+IQjZsde8lvDEEuctiWk6sYAtSX2B9mqZDFNnSVqv/h6pyzl4ocQ
 u7tRvt/28hHSofwZhUgqEfg4ofRsEfvR14JVU8b8Z4LXG6InPZufLziP9k/kMgnNt0cLxdaj
 zGQxi98q2IMWNGmGjxH+HmmdspxPEEpGBvH0aLRwvu7m1JB0Ir/wvpyatIKPF7qGm5jpm3NS
 4X7DymnPFW7ZvEwJkptRRA1SqDVZ6Sp1WtyylGyNev+ynzPSHWji36w573+8ikbubatHvAQp
 Z8phzcZUBavKysxOr0eChFbOln+6OClVIU9WZR8QtRk/afemiZn1aJ6EUc6RfxXYl6zgf1Ht
 EXeJ4m5R+7GlJNIoHTowtq7j5at3Ny98f4u7VEUOJmw4XcsvXuFnko49nvFuYWoEHfinu9O/
 dF5K4uEdCaFFDeXVtWULvvumu2a5lFqxPTHSERddOFIdDNSe9Kk35+S8OvN2rTlv5YLsVRFu
 anvRJuXneZreQne6Qxn176/RpdzWyE+a6sjq1f518duSvu2TK5nMFNWXS2htpup/Me8HhGsD
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH/d3H787V4rIGXYyyFj3oYQVZJ4owirxpRQUhCJUjLzmfsZVp
 EKlrtN5rsUlOy1aOmitNe61aipaVFmlmWmYrWqZpWUsdPubaiv45fM73e86X88cRkdI7dJhI
 mb5XUKUrUuVYTIk3rdAsoNfHJi86vR102kPw3uWm4U1uNQUD/ToKCsvsGHzmOwzoKs7R8LQ1
 j4LG66UIXAM6BN4RMwlah58Cn6GOgf6hdgaMuQj8zjoEpiYDCW2NVSTYb+YS8Lt8DENPrQeB
 8ZMbQ353LgV91hMICjrNDHQ/jobvrvs0+Du+EtA62IvA6h4jwF19BIHPlAIXLJWBddNPDCMv
 XpKQb2xEcPFTBwme7o8IbtZ9QOC8kofhi/4WCc3uCfB6oA/DM+NxDN+bCgn4UY6hOM9JQ9Pz
 HgRFZgOCzndOAjSXyjCYiioocHy8x0BTzygB700GAkorNoLL2klBg95CBM4NTN2YBOZ8DREo
 XQQYr90nYMhqY6JKEO/VnqJ4W+Vtgte+8mHeft6O+JFhA+L7SzQkr9UH2trePpI/XLmfL2no
 xfzwQAvmnYPFFF9v4fjLR4cJ/syLBbyjoIPZvDpevDJRSFVmCqqFqxLESWX+IXrPY0nWla63
 KAdpxx1DoSKOXcI5vJfoIGN2NtfWNkQGWcZO4ypPdgZ0sYhkm8O5E9aTVNCYyG7h7N4SFGSK
 nck99Lz8yxJ2Kaf39OB/oeFcaXn136DQgH59tIgIspSN5Nr7nlB6JC5GITYkU6ZnpimUqZER
 6pSk7HRlVsSujLQKFHgn68HRM3dRf3N0DWJFSD5eAlExyVJakanOTqtBnIiUyySz5sQmSyWJ
 iuwDgipjp2pfqqCuQZNFlHySJCZOSJCyuxV7hRRB2COo/ruEKDQsBxGcKjZtnX5HiPLz88Mt
 svqYQ1cPREc9NNhCcnaTM260tIdV2fCaKeE7lt36mUjqLK1bxlDD4KMMZt+ci9uy8FpXVcRw
 pGwwbkWkGk3vUnXMPRsV88FvfVvgy1weHf7mV6zrQve8qfUHv82vjbfcU6zVF2q+mJgNq70W
 j2MrfpAgp9RJisVzSZVa8Qc5S0vSSgMAAA==
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:13:14 +0000
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

For many reasons, debug_locks_off() is called to stop lock debuging
feature e.g. on panic().  dept should also stop it in the conditions.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 2 ++
 kernel/dependency/dept.c | 6 ++++++
 lib/debug_locks.c        | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index f3cc7566ddf2..236e57befb13 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -142,6 +142,7 @@ struct dept_ext_wgen {
 	unsigned int wgen;
 };
 
+void dept_stop_emerg(void);
 void dept_on(void);
 void dept_off(void);
 void dept_init(void);
@@ -194,6 +195,7 @@ struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 
+#define dept_stop_emerg()				do { } while (0)
 #define dept_on()					do { } while (0)
 #define dept_off()					do { } while (0)
 #define dept_init()					do { } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 048348ea64d2..007e1bc7d201 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -187,6 +187,12 @@ static void dept_unlock(void)
 	arch_spin_unlock(&dept_spin);
 }
 
+void dept_stop_emerg(void)
+{
+	WRITE_ONCE(dept_stop, 1);
+}
+EXPORT_SYMBOL_GPL(dept_stop_emerg);
+
 enum bfs_ret {
 	BFS_CONTINUE,
 	BFS_DONE,
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index a75ee30b77cb..14a965914a8f 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
  */
 int debug_locks_off(void)
 {
+	dept_stop_emerg();
+
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
 			console_verbose();
-- 
2.17.1

