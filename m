Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305D2C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F097D10E752;
	Mon,  6 Jul 2026 07:13:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2D23310E2F3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 06:19:53 +0000 (UTC)
X-AuditID: a67dfc5b-c45ff70000001609-7f-6a4b49005c15
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
Subject: [PATCH v19 19/40] dept: apply timeout consideration to
 hashed-waitqueue wait
Date: Mon,  6 Jul 2026 15:19:07 +0900
Message-Id: <20260706061928.66713-20-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260706061928.66713-1-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG/c75zqUNXY71wtElYqoyRwQvweVdsjgSTfZ5YRcvc5l/uGac
 jCK3tFrAxKyo1aoohXiJLThGpalQgVE3LILpcMOgEMQqNFFui6KNsG4VqAgFC8T/fnmeJ0/e
 N3l4WvmYWcprMg9K2kx1uoqVY/lwVHk8tXV72jpnZSyYjD9DV74Hw+iICUNJjZOFsLWeA1Pd
 ZQb6Rk0IQhNWGozuaQzh4hYOpptaEDhv5FPwunaKhVd3gggC9gIElkErB/6/v4DhvlsMdI8N
 IXjmOYkgfPEA/FLuYmGivYOGXwd6aAj6+xHcaOlF0OQ4ysJz8+80eJ99AI9GAywMd5ZQ8G8t
 C51trxCUWosRHLPVsODub+Cgqi4Z+uyDGO6byym45GfBeukYBeP2Sg7abE8x2A2rwNruZeAf
 hyVybFkW9BRewFA93MFAa29X5Ke7JxioN/RzMPJogAJTwyiGy1eestDY1IrBFB5BYLCGGHjg
 uc9AzQsfBa2WaxietBdy0NFwnYGBfh+TlEJCxnOYVLr+oIjxYZglzitORCbeFiNiNEfozlCA
 JsddOaRprAyTe+UiuXrqLUWK2uOJ29LDkbK6Q8TliCO2Rj/1dfz38s9SpHSNXtKu3fSDPDV0
 Jjn7HJf7vLaIMaAB5jSS8aKQKOZX+9nTiJ9l+/Q3MzIrfCT6fOP0DC8Ulouus4ORuJynBW+M
 WGA/i2eMBcIecfJF4WwPFlaJQ/YgNcMK4ROxKvSSneuPEatqPbNFsohePVk6m1EKG8Ungbt4
 LmOTidca4+Z4ifinw4fNSFGG5lUipSZTn6HWpCcmpOZlanITfszKqEORsdmPTO67iYIPdjUj
 gUeqKAUkbUtTMmq9Li+jGYk8rVqoiF29PU2pSFHnHZa0Wfu1h9IlXTP6kMeqaMWGsZwUpfCT
 +qB0QJKyJe17l+JlSw2oaP4J+lNv4orVRWnmC/+59V/tVqycuLXYrD/aF62gk/Z3Tq0JninM
 7f7W4vVtWqOM+TiUbH3jWfT/X53jzO6SnTsqbv92UZjOkTmCy1QrSSkpiGejpuqXjYv8dwlt
 h/duOb/59hF1b1v159kVNveXI438Td36rd3RXamL3AH/zuVGFdalqtfH0Vqd+h2bAKxEaAMA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93XrqvVZRldtOegkh5WkHHKiKKgS6XUHxHUHzny0uabrSyD
 HnONVlrN0SY1tWW6QpeuaZbJaCjZw0TNMsuWSdMUNWNpY25zbUH/HD7nfL/ny/nj0Li4gYyh
 5VkneUWWNENCCQlhcqJ6XYjbl7bhpTERtJoL8KXfTUKPyknA1KSWgJJaKwVB0xMBaO23SHj1
 MZ+AzppqBP1TWgRevwkHTWOIgKC+VQCTvj4BGFQIQo5WBMYuPQ69nc9xsNarMPhtm6FgtMWD
 wDDgpqB4REXAhKUQwe0hkwBGXuyB8f4mEkKuHxh8/DOGwOKewcDtvIwgaEyHO+V14XXjLwr8
 7R04FBs6EdwdcOHgGfmGoL71KwLHg3wKBnWPceh2z4X3UxMUvDYUUDDeVYLBTxsF5nwHCV1v
 RxGUmvQIhj47MFDfq6XAWGonoPHbMwF0jQYw+GLUY1BtT4J+yxABbbpyLHxu2PVoIZiK1Vi4
 DGNgeNiEgc9SJdhRiTiv5jrBVdU1YJzmXZDirGVWxPmn9YibrFTjnEYXblvGJnDuUt1prrJt
 jOKmpz5QnOOPmeDelLNcxZVpjCtqX8c13nYJDuw8ItyWymfIc3nF+u0pQpm3ICnnuuDMoK2I
 vIgGyKuIpllmE2sJHbyKomiKWcX29vrwCEczy9i6a0Nhi5DGme6lbKHlGhER5jOH2MCPG2SE
 CWYFO2bxYBEWMZvZau8wFWGWWcpW25z/gqLC85pA6T+PmElg+yZeEjokNKNZVShanpWbKZVn
 JMQr02V5WfIz8cezM+0o/E2Wc4Gip2iye08zYmgkmSOCHXvTxKQ0V5mX2YxYGpdEi1bG7UsT
 i1KleWd5RfYxxakMXtmMYmlCslC09zCfImZOSE/y6Tyfwyv+qxgdFXMRmVJvGq6k7D+WsEys
 1QfvL99yILbivn9jh/mXN84ze/7yTZ9kOS3bD/U1FAziM78XqBn54vNNgcINu4QNvvb0J7vX
 ixXlR+MaX/QULZEld1doxd9L+k6rti7a3bGm4r3f9c4WE1/Wk+t2KY+aT6XEzltrtcc6c3x8
 yOZN1DnrPZ8khFIm3bgaVyilfwH0aI66SQMAAA==
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

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 179a616ad245..9885ac4e1ded 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -258,7 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-- 
2.17.1

