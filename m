Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBFD606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=NZikNmCq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZMi1T3A3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 721B510FD86;
	Wed, 21 Oct 2026 11:34:06 +0000 (UTC)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C70E10FD86
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:33:54 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7796D7A0058
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 07:33:53 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Wed, 21 Oct 2026 07:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1792582427;
 x=1792668827; bh=FhfwrUgR3BveD2SaYPstYM1HYNtfUANzUsTcnVa0coU=; b=
 NZikNmCq5hnFipHY3T3pHMhBaTnl5WF9NiEBjL0s0T9H7YK0NWggwWZT7XRABt6s
 80aZT7L/mn7hBxbXyvbelzxKReDlV6XczHqLq199f+utgfU0J9sO79fHl7C7J3mf
 Bj6rTe0FfUPSQ6TOZT1pcDv/fUgVPaDdzy3h010YDC5u8Kw5mxEfJm4tRghBs1+x
 f2Hl2CcdS0R0Aw1hwAFbrMOIOwZ9pEIrRk32oWsXw+fp/uwIxs3OLsz4zsGK747f
 w9Cc47DxTItHCjPrLCiAT8tUsst752fa5wJ9UMoDoL0jxQ3lLhLJ1SmR9DrpcEHP
 3jf9wFzgvRcfC3tZO1Ed5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792582427; x=
 1792668827; bh=FhfwrUgR3BveD2SaYPstYM1HYNtfUANzUsTcnVa0coU=; b=Z
 Mi1T3A3TRsaKUk6rWpMJbtzdUnoNSwXVq8w8lMDzbbfyPPlV39s3XESm+xtZ79YE
 gTzldWPSXK99VHccb7uiXc/TqHHMgtjLQ6Z8np97mjjieMumXfRjUljfjXH8dotJ
 6xBRD7s2xxwBk9U/VIShf/2KsQvSS5wVE1PUQM4i18ELwyYm8FIHFf7PbhRWpHZ7
 81d1WevFEQigBSrK0+Ug9bbNTkK526fgaF1uhFtDGVm7xqdNYh6Atx9if497qIwG
 qvMuoRClJ+uzZTrkBau4spI0GmZD4XR+6fNCVuekNUap8Aba1z/qy1vxUgr3rhTu
 +HsJyuSTDtFtfksqjWv9Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792582427; d=arndb.de; mf=PGFybmRAYXJuZGIuZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:V7ahjY7Ig0bW+QeRUzPjUKJLVoBRDCaaV/sfD/uHhjeaFFz
 nHsXzZTkvFnXqBboRAtkItY5mQNAqFcK+q+kmHH8txAz6moLyWQ7Iu9HxiXQrbS8
 DuYssuCj/EuRhM49QlNKnbxIJKuLAcBoK5ozl8hH78GnjutF8W72pRibYcYMQ3oB
 JsMZ+dfemIHMMn/CwLpiO06/VBhILMCAZ4ZQwFuDMJ3tjwMv1X5mq6jZc1eWohDY
 YImMZ4UV/gW+883AVe6qi+70uN+EN0ey7nBq/NN88h+F4IqcYz5nGQk4Xq6nJPal
 mHH8e/4l0uxPni7VmRzly9j1cr4BIqVzMmQv1KA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:wdfcJkxIoZbQsw04DDRm+doRsUlelEbDIxnYdy4YTpo=:AUQ6V3jU1DCpdN5Uc9KTJwbNgDBLdxc+xFCQfHu1Xw4=;
X-ME-Sender: <xms:FqPYauHO6wt4-wliZSJDZf0nZMf-odMvfJTORmSG3IdOnFMIry0Xbw>
 <xme:FqPYaqIPQKB2HZ1vSoE-23_MoNA33LR57IFAZ1VcRddP5EtRECozcG0xIpnNXn6pc
 7MvrK5j0zTmbulYX-wX1kc5ZL7NzS0PCslT_5SnOeHvbZysYxGaG4bj>
X-ME-Proxy-Cause: dmFkZTFha+pd8I8exs+OpH7qLvKdVOk62O7Il4mAGiDExZLyUfVdeh5R92a7RS4G5MsUWG
 WJRVVQeroTl1+yM8nKEX/qNHPt5al0gdhWUH6Jes403bRQhp/0BADM9CG2lUgfDKsXCPFd
 6LoxhNAfKM+IMz7oZhDL/F1Z3DsPvbU3m7pSwIdp+l0c3tG00eZ4VEmqNk9NWaLNOB108e
 ttM14e8KKQajBsNpQpe5I4XyarIcoVMGwjmmE8iYNUqdLbDhWtRcOl9nJ14XtFEh5TQFUT
 5SwnO6ii/j847TfaCEt35AcoYAbyoN9T2RQgn45w349P++WRgqANt2N3Oek+5zETp7R8tm
 Kv3yUoIUHwrDeYSq7Q5yUICjBuHZyezx0FnpdqG3+0hGq0ItM1dR1phVkcyJHOo6g3/+dV
 rVmxpNJSku++flgi8bMWOAaSarLdAWABTmtS6QTreA5HkmAbum4N0kw+4trUsr96Lda5AV
 rd9+yelGrZNNlx7q3DD9A01eiUFBQALtnhj5a1UDd4GopqBCI9onkhFp5AUHD7+5qFwq2O
 cTm9ZOLp5L0kCApIY8k4347G5fmSLU7hltEQOTfhIQGpXBZWLwLjdLSCSKDj0/WD2VTx+t
 AI5G7giuK91aAqU7jelivMT6L2hfIBKPX1lpzxGikBgdPQUPsSgHr5Cuiztg
X-ME-Proxy: <xmx:GKPYamsrFkb3jIeI59fcTde-gTk_8ZuSzkTqr5q5zQwr_JGAyeHYuw>
 <xmx:GKPYap8mgbKzRwrZN_OBeMM2_fsv5TfrFwT8Rm9NGZzj9AAVgeRpIQ>
 <xmx:GKPYatSKYiRTK9Jf35BMq-UaYXGcFpy8TPQkuOhBQDergM7N7kfepA>
 <xmx:GKPYarUnm7ypPLDFu40nx6e3zZTxWEWzEXZrEKlIIRx7Jz03SMHuSA>
 <xmx:G6PYalkD1JFlzOBhTuBitH1hqlywl1aJX5Eru1n8URBeYnvj5dfF2ixd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id AF66432A0093; Wed, 21 Oct 2026 07:33:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: Anl2GdpqQwQR
Date: Wed, 21 Oct 2026 13:33:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Stanner" <phasta@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Message-Id: <9f4bbc9a-fc36-4e3a-9c42-d18419c9d025@app.fastmail.com>
In-Reply-To: <20261021095512.1345191-3-phasta@kernel.org>
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-3-phasta@kernel.org>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
Content-Type: text/plain
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026, at 11:55, Philipp Stanner wrote:
> The kernel already has test_bit_acquire(). A set_bit_release(), however,
> was missing so far. It can be expected to be useful for parties that
> need release ordering, but not the stricter full ordering of the other
> bit-setting functions.
>
> Add set_bit_release().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

> +/**
> + * set_bit_release - Set a bit with release ordering
> + * @nr: Bit to set
> + * @addr: Address to start counting from
> + *
> + * This is an atomic ordered operation (implied write memory barrier).
> + */

Can we fix the mismatch between code comments and documentation for
the set_bit()/clear_bit()/change_bit() barrier semantics while adding
this? I'm always confused by this and the new function makes it harder
to understand in the current form:

- Your patch description mentions that set_bit() has strong rw
  barrier semantics and that set_bit_release() would be a weaker
  write-barrier version of it. This makes sense given the
  set_bit() implementation based on strong raw_atomic_long_or()
  in arch_set_bit() and the text in Documentation/memory-barriers.txt

- Contrary to that, the kerneldoc comment over set_bit() mentions
  "This is a relaxed atomic operation (no implied memory barriers)"
  and leaves out the kcsan_mb() that is in test_and_set_bit().
  This makes the new set_bit_release() sound like a /stronger/
  version of set_bit() the same way that test_bit_acquire()
  is a stronger version of the (relaxed) test_bit().

As I understand it, the kerneldoc comments here are incorrect
and trace back to the include/asm-i386/bitops.h file before the
git era. The patch below should make them consistent with your
patch and with the actual implementation.

       Arnd

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index c010d54275e4..df200802e929 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -18,13 +18,14 @@
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
- * This is a relaxed atomic operation (no implied memory barriers).
+ * This is an atomic fully-ordered operation (implied full memory barrier).
  *
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
 static __always_inline void set_bit(long nr, volatile unsigned long *addr)
 {
+	kcsan_mb();
 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_set_bit(nr, addr);
 }
@@ -34,10 +35,11 @@ static __always_inline void set_bit(long nr, volatile unsigned long *addr)
  * @nr: Bit to clear
  * @addr: Address to start counting from
  *
- * This is a relaxed atomic operation (no implied memory barriers).
+ * This is an atomic fully-ordered operation (implied full memory barrier).
  */
 static __always_inline void clear_bit(long nr, volatile unsigned long *addr)
 {
+	kcsan_mb();
 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit(nr, addr);
 }
@@ -47,13 +49,14 @@ static __always_inline void clear_bit(long nr, volatile unsigned long *addr)
  * @nr: Bit to change
  * @addr: Address to start counting from
  *
- * This is a relaxed atomic operation (no implied memory barriers).
+ * This is an atomic fully-ordered operation (implied full memory barrier).
  *
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
 static __always_inline void change_bit(long nr, volatile unsigned long *addr)
 {
+	kcsan_mb();
 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_change_bit(nr, addr);
 }
