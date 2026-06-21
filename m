Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EBCCD98F0
	for <dri-devel@archiver.kernel.org>; Sun, 21 Jun 2026 10:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9BB10E1EF;
	Sun, 21 Jun 2026 10:39:08 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com
 [216.40.44.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DC288C11;
 Sun, 21 Jun 2026 10:39:07 +0000 (UTC)
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
 by unirelay05.hostedemail.com (Postfix) with ESMTP id A4F80403B5;
 Sun, 21 Jun 2026 10:39:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by
 omf15.hostedemail.com (Postfix) with ESMTPA id A063517; 
 Sun, 21 Jun 2026 10:38:58 +0000 (UTC)
Date: Sun, 21 Jun 2026 11:38:55 +0100
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@kernel.org>, Steven Rostedt <rostedt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_tracing=3A_Add_CONFIG=5FTRA?=
 =?US-ASCII?Q?CE=5FPRINTK=5FDEBUGGING_to_clean_up_kernel=2Eh?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87ik7cmcb7.ffs@fw13>
References: <20260621093430.264983361@kernel.org>
 <20260621093811.168514984@kernel.org> <87ik7cmcb7.ffs@fw13>
Message-ID: <65FD4729-3DEB-44BF-B085-1F72A0B7BF3A@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: 1rpq566iuu696tbe6de19udoqya4ijdw
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A063517
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+altd1Yz9Y3NVTA4Q+RMlDrpJ2CoeKO4s=
X-HE-Tag: 1782038338-801961
X-HE-Meta: U2FsdGVkX1+UIJ7kmLtbV5k3wlv8csQwDalYtg7WqKufnOv7be+VuRDa3ft8H3X3zzwfr+uJaQZNz0sDC4oyI98+t0mZe8z4QM7YVjOJ7k9IvaQO5X/gwLzm/T/snIDf9B1tqJjVQMbg/Fnqr36PDksXLybxk5Wk4szMxT0dI7RGk8YrmbCkpbiPzakXtErPJu/4LvGLwyxtHWX9zek973SlOgxvLlgqkXDRAT2+DqJr5WMtzWdQf68LXDneXrIH36GLwhtQHs9JqXlxGiQxIii+hAq+RQvxokuLaf3ukb8Kl6fOR60wgmpjUFzbMjevVHTotC5pRIjw762yNXa4cwdML3kSKjmj+IzsGxPuo8Puez99eB9siQ==
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



On June 21, 2026 11:13:00 AM GMT+01:00, Thomas Gleixner <tglx@kernel=2Eorg=
> wrote:
>On Sun, Jun 21 2026 at 05:34, Steven Rostedt wrote:
>> Instead of having trace_printk=2Eh included in kernel=2Eh, create a con=
fig
>> TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
>> Makefile to allow developers to add trace_printk() without the need to =
add
>> the include for it=2E Having it included in the Makefile keeps it from =
being
>> in the dependency chain and it will not waste extra CPU cycles for thos=
e
>> building the kernel without using trace_printk=2E
>
>IOW, you make it worse just because=2E
>
>With the header being separate I add the three trace_printk()s and the
>include to the source file I'm investigating=2E The recompile will build
>exactly this source file=2E
>
>Having to enable the config knob will result in a full kernel rebuild
>for no value=2E
>
>Seriously?

Like having lockdep enabled, this would always be set in the development e=
nvironment=2E It's not something to only enable when you need to add a trac=
e_printk=2E If you don't want to rebuild everything, by all means add the i=
nclude file by file=2E There's nothing preventing you to do that with this =
solution=2E

-- Steve=20

P=2ES=2E I'm replying on my phone as I'm in the London Tube=2E Thus why I'=
m not trimming my email=2E


>
>Thanks,
>
>        tglx
>
