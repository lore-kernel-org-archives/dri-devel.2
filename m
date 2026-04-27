Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95F4FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5790910E8ED;
	Mon, 27 Apr 2026 19:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JLlR7hxh";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2D710E8ED
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 19:01:50 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-678a1642a81so5535270a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1777316509; x=1777921309;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eo95+vxRQveZjyTXx2nQjz3zXl5qvV2nK5Gunw4PJlE=;
 b=JLlR7hxhqkpRMykPwDnKwDr53FwLe1nfjsJSqr8BoZAZodSTsbMYAZGTlEIkBYgoA2
 hjCiI7KUtKVmyXWpO5nWj1xYWyE6tylWFJVdsXLzy6s/P012YKHoF0BA2X8efM7pXk0e
 PAI1Ha0ge1ZmK2mNWP6Wbh9/bB7RtTF1SC7Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777316509; x=1777921309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eo95+vxRQveZjyTXx2nQjz3zXl5qvV2nK5Gunw4PJlE=;
 b=RU3kcBZDeAXOvuCERi5vrl8oEreCXz+x5Y/c1J56Teg00YOvZheau1D6uhKWlOwfZd
 /eKlPXithEB3q2JstZN2IA/KZUQJug0e1PBEY+H6ZQhSq+Qkt/F/Sl4h4dC4QPvfgJch
 Kg5ra8ivL/4UDHp3tuT7jxPs94PaEQJjhAk/9aaFMST986CqIyjMbbXqymMUkOWSSxes
 salK2heJxD6dMMb+Px/JtC6gHUePwKEuFbzoUarqoj44pgCxgmdrcqjL4udlH3YZ33lY
 WF0vwwsAifhB+yZJbZ5dr1LhDV/a/z0j4bRLt1DhnxsuqLr4j6pqdQV2L61GhEYwE7FC
 e9eA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DH+d8FzNUGzc0WZQBfzIr4DsDytsSleHeUWA3iJZNjhiKz5q5TTCUDb1sw2A03D0q3lV/oTB5giQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwlCjrp2TaQqrylz+D40eNZHRP47h0uxOLcP7Q3MaChl/Ox25z
 E+qZOkY6n7+iKIVTlY1OxwgoRYBOqFdHN3+zUhMz9VLzbO6vRTAan2gtz5zwaL4HK5zars3cUqV
 7w59gwK0=
X-Gm-Gg: AeBDiesiRwTOuzNS+CTXBZp39NnFM5IkXMhFrFeon4cHcJZuJIRKGiyxO+mVHvZ1J4V
 fuHJv6LNCloic89tFmXALikaDX00ScAaGLUdeBv4u69ckW43uOmVRYTpeRl4DKEg2T/ObyyYz3E
 aDsfhpiE1zPqMvEUlK5+is5c6j3YwqtveqcqGhu67H1Dx0kD0L+SOGBjjHQ4oi9jBZ2pkY+STMt
 9yQKKaG9ITkMmHnLZQWeFMG3Iple2p1pe5s3mHzN2ZOAvPfmoFt/z3inPasHKaNp4hXVqzxp9Ww
 iWiVtkqaPrUcGHneya+sbzGKCFDzNtDNHVBxGz8DfnpXoRBUXsSv/3qVHOto7ygNVRMaHIvsQzD
 rgvIa97TJoZZeAK1edVMa2HGF+ilqoS7JhNadSeVhfDDNN/CVrtcuxgrpMFVqr1+TvakQRbtNiB
 KUMTCyvKLsxvjrX7dkr07SSME2V28OND9pfrVaWlhhk8rH2WKsmdp6Lg5H/LWK154DH51jaxP82
 XT3+vhh9R0=
X-Received: by 2002:a05:6402:324:b0:670:f48b:caf8 with SMTP id
 4fb4d7f45d1cf-679b66c942cmr194088a12.3.1777316508617; 
 Mon, 27 Apr 2026 12:01:48 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com.
 [209.85.218.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-679b6869a6esm57575a12.31.2026.04.27.12.01.42
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 12:01:44 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-ba9ad0fbc3aso978580666b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 12:01:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+3p91yzUCrq839KmpJBb+wRU0iEBGeGyvpeyNYnHrU8X/xLvEAFVOoAiOhmqIh7791IlHZsPah3+M=@lists.freedesktop.org
X-Received: by 2002:a17:907:9495:b0:ba3:a8ef:3597 with SMTP id
 a640c23a62f3a-bb80443c92emr2812866b.25.1777316502372; Mon, 27 Apr 2026
 12:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org>
 <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
In-Reply-To: <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 12:01:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com>
X-Gm-Features: AVHnY4JOOuu1ghb35GF5M7sO3SAfkj4A7WtLiFNY579kWyh92WWRKfW5QE_KjRI
Message-ID: <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to
 copy_{to/from}_user_partial() when relevant
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, 
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
 linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c765e2065075bee2"
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

--000000000000c765e2065075bee2
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 10:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> In a subsequent patch, copy_{to/from}_user() will be modified to
> return -EFAULT when copy fails.

Please don't do this.

This is a maintenance nightmare, and changes pretty much three decades
of semantics, and will cause *very* subtle backporting issues if
somebody happens to rely on the old / new behavior.

I understand the reasoning for the change, but I really don't think
the pain of creating yet another user copy interface is worth it.

We already have a lot of different versions of user copies for
different reasons, and while they all tend to have a good reason (and
some not-so-good, but historical reasons) for existing, this one
doesn't seem worth it.

The main - perhaps only - reason for this "partial" version is that
you want to do that "automatically inlined and optimized fixed-sized
case".

But here's the thing: I think you can already do that. Yes, it
requires some improvements to unsafe_copy_from_user(), but *that*
interface doesn't have three decades of history associated with it,
_and_ you're extending on that one anyway in this series.

"unsafe_copy_from_user()" is very odd, is meant only for small simple
copies that can be inlined and it's special-cased for 'objtool' anyway
(because objtool would have complained about an out-of-line call,
although it could have been special-cased other ways).

In other words: unsafe_copy_from_user() is *very* close to what you
want for that "Oh, I noticed that it's a small fixed-size copy, so I
want to special-case copy-from-user for that".

The _only_ issue with unsafe_copy_from_user() is that you can't see
that there were partial successes. But if *that* was fixed, then this
whole "create a new copy_from_user interface" issue would just go
away.

So please - let's just change unsafe_copy_from_user() to be usable for
the partial case.

And the thing is, all the existing unsafe_copy_from_user()
implementations already effectively *have* the "how much did I not
copy" internally, and they actually do extra work to hide it, ie they
have things like that

        int _i;

that is "how many bytes have I copied" in the powerpc implementation,
or the x86 code does

        size_t __ucu_len = (_len);

where that "ucu_len" is updated as you go along and is literally the
"how many bytes are left to copy" return value that is missing from
this interface.

So what I would suggest is

 - introduce a new user accessor helper that is used for *both*
unsafe_copy_to/from_user() *and* the "inline small constant-sized
normal copy_to/from_user()" calls

 - it's the same thing as the existing  unsafe_copy_to/from_user()
implementation, except it exposes how many bytes are left to be copied
to the exception label.

IOW, it would look something like

     #define unsafe_copy_to_user_outlen(_dst,_src,_len,label)...

which is exactly the same as the current unsafe_copy_to_user(),
*except* it changes "_len" as it does along.

And then you use that for both the "real" unsafe_copy_user and for the
"small constant values" case.

Just as an example, attached is a completely stupid rough draft of a
patch that does this for x86 and only for unsafe_copy_to_user().

And I made a very very hacky change to kernel/sys.c to see what the
code generation looks like.

This is what it results in on x86 with clang (with all the magic
.section data edited out):

        ... edited out the code to generate the times
        ... this is the actual user copy:
        # HERE!
        movabsq $81985529216486895, %rcx        # imm = 0x123456789ABCDEF
        cmpq    %rcx, %rbx
        cmovaq  %rcx, %rbx
        stac
        movq    %r13, (%rbx)                    # exception to .LBB45_8
        movq    %r14, 8(%rbx)                   # exception to .LBB45_8
        movq    %r15, 16(%rbx)                  # exception to .LBB45_8
        movq    %rax, 24(%rbx)                  # exception to .LBB45_8
        clac
.LBB45_6:
        movq    jiffies(%rip), %rdi
        callq   jiffies_64_to_clock_t
.LBB45_7:
        addq    $16, %rsp
        popq    %rbx
        popq    %r12
        popq    %r13
        popq    %r14
        popq    %r15
        retq
.LBB45_8:
        clac
        movq    $-14, %rax
        jmp     .LBB45_7

and notice how the compiler noticed that the 'outlen' isn't actually
used, and turned the exception label into just a "return -EFAULT" and
never actually generated any code for updating remaining lengths?

That actually looks pretty much optimal for a 32-byte user copy.

And it didn't involve changing the semantics at all.

Just to check, I changed that "times()" system call to return the
number of bytes uncopied instead (to emulate the "I actually want to
know what's left" case), and it generated this:

        # HERE!
        movabsq $81985529216486895, %rcx        # imm = 0x123456789ABCDEF
        cmpq    %rcx, %rbx
        cmovaq  %rcx, %rbx
        stac
        movl    $32, %ecx
        movq    %r13, (%rbx)                    # exception to .LBB45_7
        movl    $24, %ecx
        movq    %r15, 8(%rbx)                   # exception to .LBB45_7
        movl    $16, %ecx
        movq    %r14, 16(%rbx)                  # exception to .LBB45_7
        movl    $8, %ecx
        movq    %rax, 24(%rbx)                  # exception to .LBB45_7
        clac
        xorl    %ecx, %ecx
.LBB45_8:
        movq    %rcx, %rax
        addq    $16, %rsp
        popq    %rbx
        popq    %r12
        popq    %r13
        popq    %r14
        popq    %r15
        retq
.LBB45_6:
        movq    jiffies(%rip), %rdi
        jmp     jiffies_64_to_clock_t           # TAILCALL
.LBB45_7:
        clac
        jmp     .LBB45_8

so it all seems to work - although obviously the above is *not* the normal case.

NOTE NOTE NOTE! The attached patch is entirely untested. I obviously
did some "test code generation" with it, but I only *looked* at the
result, and maybe it has some fundamental problem that I just didn't
notice. So treat this as a "how about this approach" patch, not as
anything more serious than that.

And the kerrnel/sys.c hack is very obviously just that: a complate
hack for testing.

A real patch would do that "for small constant-sized copies, turn
copy_to_user() automatically into "_small_copy_to_user()".

The attached is *not* a real patch. Treat it with the contempt it deserves.

             Linus

--000000000000c765e2065075bee2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mohk3mm10>
X-Attachment-Id: f_mohk3mm10

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaCB8IDE3ICsrKysrKysrKysrLS0tLS0tCiBp
bmNsdWRlL2xpbnV4L3VhY2Nlc3MuaCAgICAgICAgfCAxNiArKysrKysrKysrKysrKysrCiBrZXJu
ZWwvc3lzLmMgICAgICAgICAgICAgICAgICAgfCAgMyArKy0KIDMgZmlsZXMgY2hhbmdlZCwgMjkg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS91YWNjZXNzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmgKaW5kZXgg
M2EwZGQzYzJiMjMzLi4zYjJjNTdjOTE0MTggMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3VhY2Nlc3MuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmgKQEAgLTYw
NiwxNSArNjA2LDIwIEBAIF9sYWJlbDoJCQkJCQkJCQlcCiAJCWxlbiAtPSBzaXplb2YodHlwZSk7
CQkJCQkJXAogCX0KIAotI2RlZmluZSB1bnNhZmVfY29weV90b191c2VyKF9kc3QsX3NyYyxfbGVu
LGxhYmVsKQkJCVwKKyNkZWZpbmUgdW5zYWZlX2NvcHlfdG9fdXNlcl9vdXRsZW4oX2RzdCxfc3Jj
LF9sZW4sbGFiZWwpCVwKIGRvIHsJCQkJCQkJCQlcCiAJY2hhciBfX3VzZXIgKl9fdWN1X2RzdCA9
IChfZHN0KTsJCQkJXAogCWNvbnN0IGNoYXIgKl9fdWN1X3NyYyA9IChfc3JjKTsJCQkJCVwKLQlz
aXplX3QgX191Y3VfbGVuID0gKF9sZW4pOwkJCQkJXAotCXVuc2FmZV9jb3B5X2xvb3AoX191Y3Vf
ZHN0LCBfX3VjdV9zcmMsIF9fdWN1X2xlbiwgdTY0LCBsYWJlbCk7CVwKLQl1bnNhZmVfY29weV9s
b29wKF9fdWN1X2RzdCwgX191Y3Vfc3JjLCBfX3VjdV9sZW4sIHUzMiwgbGFiZWwpOwlcCi0JdW5z
YWZlX2NvcHlfbG9vcChfX3VjdV9kc3QsIF9fdWN1X3NyYywgX191Y3VfbGVuLCB1MTYsIGxhYmVs
KTsJXAotCXVuc2FmZV9jb3B5X2xvb3AoX191Y3VfZHN0LCBfX3VjdV9zcmMsIF9fdWN1X2xlbiwg
dTgsIGxhYmVsKTsJXAorCXVuc2FmZV9jb3B5X2xvb3AoX191Y3VfZHN0LCBfX3VjdV9zcmMsIF9s
ZW4sIHU2NCwgbGFiZWwpOwlcCisJdW5zYWZlX2NvcHlfbG9vcChfX3VjdV9kc3QsIF9fdWN1X3Ny
YywgX2xlbiwgdTMyLCBsYWJlbCk7CVwKKwl1bnNhZmVfY29weV9sb29wKF9fdWN1X2RzdCwgX191
Y3Vfc3JjLCBfbGVuLCB1MTYsIGxhYmVsKTsJXAorCXVuc2FmZV9jb3B5X2xvb3AoX191Y3VfZHN0
LCBfX3VjdV9zcmMsIF9sZW4sIHU4LCBsYWJlbCk7CVwKK30gd2hpbGUgKDApCisKKyNkZWZpbmUg
dW5zYWZlX2NvcHlfdG9fdXNlcihfZHN0LF9zcmMsX2xlbixsYWJlbCkJCQlcCitkbyB7CQkJCQkJ
CQkJXAorCXNpemVfdCBfX3VjdV9sZW4gPSBfbGVuOwkJCQkJXAorCXVuc2FmZV9jb3B5X3RvX3Vz
ZXJfb3V0bGVuKF9kc3QsX3NyYyxfX3VjdV9sZW4sbGFiZWwpOwkJXAogfSB3aGlsZSAoMCkKIAog
I2lmZGVmIENPTkZJR19DQ19IQVNfQVNNX0dPVE9fT1VUUFVUCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3VhY2Nlc3MuaCBiL2luY2x1ZGUvbGludXgvdWFjY2Vzcy5oCmluZGV4IDU2MzI4NjAx
MjE4Yy4uMWE3MGVmNzA3ODRjIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaAor
KysgYi9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaApAQCAtODc0LDQgKzg3NCwyMCBAQCB2b2lkIF9f
bm9yZXR1cm4gdXNlcmNvcHlfYWJvcnQoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhciAqZGV0
YWlsLAogCQkJICAgICAgIHVuc2lnbmVkIGxvbmcgbGVuKTsKICNlbmRpZgogCitzdGF0aWMgX19h
bHdheXNfaW5saW5lIF9fbXVzdF9jaGVjayB1bnNpZ25lZCBsb25nCitfc21hbGxfY29weV90b191
c2VyKHZvaWQgX191c2VyICp0bywgY29uc3Qgdm9pZCAqZnJvbSwgdW5zaWduZWQgbG9uZyBuKQor
eworCXNpemVfdCB1bmNvcGllZCA9IG47CisKKwltaWdodF9mYXVsdCgpOworCWlmIChzaG91bGRf
ZmFpbF91c2VyY29weSgpKQorCQlyZXR1cm4gbjsKKwlpbnN0cnVtZW50X2NvcHlfdG9fdXNlcih0
bywgZnJvbSwgbik7CisJc2NvcGVkX3VzZXJfd3JpdGVfYWNjZXNzX3NpemUodG8sIG4sIGZhaWxl
ZCkKKwkJdW5zYWZlX2NvcHlfdG9fdXNlcl9vdXRsZW4odG8sIGZyb20sIHVuY29waWVkLCBmYWls
ZWQpOworCXJldHVybiAwOworZmFpbGVkOgorICAgICAgIHJldHVybiB1bmNvcGllZDsKK30KKwog
I2VuZGlmCQkvKiBfX0xJTlVYX1VBQ0NFU1NfSF9fICovCmRpZmYgLS1naXQgYS9rZXJuZWwvc3lz
LmMgYi9rZXJuZWwvc3lzLmMKaW5kZXggNjJlODQyMDU1Y2M5Li42NWIyZDAxMDNhNzMgMTAwNjQ0
Ci0tLSBhL2tlcm5lbC9zeXMuYworKysgYi9rZXJuZWwvc3lzLmMKQEAgLTEwNjcsNyArMTA2Nyw4
IEBAIFNZU0NBTExfREVGSU5FMSh0aW1lcywgc3RydWN0IHRtcyBfX3VzZXIgKiwgdGJ1ZikKIAkJ
c3RydWN0IHRtcyB0bXA7CiAKIAkJZG9fc3lzX3RpbWVzKCZ0bXApOwotCQlpZiAoY29weV90b191
c2VyKHRidWYsICZ0bXAsIHNpemVvZihzdHJ1Y3QgdG1zKSkpCisJCWFzbSB2b2xhdGlsZSgiIyBI
RVJFISIpOworCQlpZiAoX3NtYWxsX2NvcHlfdG9fdXNlcih0YnVmLCAmdG1wLCBzaXplb2Yoc3Ry
dWN0IHRtcykpKQogCQkJcmV0dXJuIC1FRkFVTFQ7CiAJfQogCWZvcmNlX3N1Y2Nlc3NmdWxfc3lz
Y2FsbF9yZXR1cm4oKTsK
--000000000000c765e2065075bee2--
