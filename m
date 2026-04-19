Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB17EA719B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:14:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC71B10E3B4;
	Sun, 19 Apr 2026 13:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Jibs7OLh";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C4710E3B4
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 13:14:16 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-651bf4a4140so2167327d50.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 06:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776604455; cv=none;
 d=google.com; s=arc-20240605;
 b=MOI5yeW2vRqKqwX4eW4y+IFlKIG5i9HlcarkAtey7trKOUZ8C6x11DcWeCdzrlNX+T
 0bBgxpdWR6hvxgBMSJLCf3I4CC4YMC0qusNQ4OAeQhaysx+aEvrcYn6G5vKbVm3iJRhq
 853KBTqSsFhb0EUlAjhZxFVxsiNh+XaLwZGHYgSx734WHgUlKEcAkAIjPnyeZ6yC3B/6
 2VEE/jpE31aPUqNKgj87u/HLDxZN44ejTOl8r+n1ryLZOBSGe+eZB30k9xmwDobnWb4t
 wokBkkgHWN9FrFjCpNJ+6cMm6O658BzRtDVzP+JHZM7udkhzqfF1AqPq5nAobcORZ1Po
 H7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
 fh=XT6W+YwhQPzUtBfJpSgqZpbs7iY2jb8NBQi7xnYJEWA=;
 b=RJ+N/7/HPxLp9sX7l/1b0b4scy7GwfW7W1SS+U3LbhiGhK5XofGXrIVBnM6F9zcVx+
 /ANfZ10Ru4dD2xVTbDKroZZwS6qpepX/jSgVyPcxLHG2d3O1rjXsbFmCwBaWEMnco3sq
 G6igT5AOyYAapNfY9mLWB/9XoKwoZ+mLH/S+hUzDPxI1dssyDDlXncDIU7E8C6ltyanM
 qxIjcwma2WdC4svnnWi94oOFHOU3GmGiB8X6wrwcDeooAOoVySys3/S0QmKwfcHeQVJ/
 QLXEdYzt2x3dULqOo/Gwdfvu3D+tigbbglzamtNyna/p6lcMHT8bDegr3wTzmv9ygnx3
 rvGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitbyteword.org; s=google; t=1776604455; x=1777209255;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
 b=Jibs7OLhFfebc5PhEudnPbNm04xNAqNr9P6GkMSa9H76ARlC7dVOSWEmVP5CnCT9kp
 EEzVxnXSqvSRLcADNbfWdOLBYymJLhhc4UIJYUTu8p4/gPcKEDLnZLFzPtdPPwY/+lMX
 XldLFiRcoe6B2X81h3SHFAnGwwFU2upd0v9Dk8vW1VreBe2zw5mzgA+/y8BwgmFsqTuM
 uOvAED39WhBjHDUpGAHlBHNI3XTvfe1N20wuzZ5sJR6Wq8nKx4+E8Ap2DaHOVp20DQpG
 nYwHAoTRaIItSA6GqHssMR9DV+CkJAqI8auSyK9fw/qesIzBF8fCa/ya+NEF5xtccISb
 OIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776604455; x=1777209255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X+WVMuAIY6fuTgPsvbyDiChtmsWhcTJteNRfYOEl4tw=;
 b=NiQMaCxUjfX4BzyDCZdavn8ek601qSGy1qecRDcs0jLuZm+NrjUhWAm8WYEc18CZEI
 OVDvNhzmnpgTbWGn7YvBoYQX/UOfB45xKpmVP1fKrWoespUoBSlCry58M7FGMTHayJyP
 6VW5/xYBG8QN6/gQn+zZHY7JJxs6VV4jAqrp9kHt9/GCrGLL3D+PAwT4CS3zSjo2iYEX
 vitfJsxCY+oV42Zcf+b+xHexUVDJ1S/NckPzGp+iEhRFCZoTBnHtWZzBAZRqK81Vzodf
 HS1WYV6ddK+ICYZ/d5b5xVBXQ9zGnr44CUnxXjx+uCvxq9Lj7j+yTGbGI0W+NJdl9THI
 R2Fw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hZ/bL3YNWy9q89XFAt7AQ6EMTeYGiHD2a/HlQsiiJM9IPh8zWv8OKkhgR9yi4UxaDzf+gLj4Pa3c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz09x0I8EzRVSGv/EJ5yfpBYgy73HBnYqOLZ0eV/k6qpMPdZTQL
 N57OvilISqwUdn+Eo488I1GsYkr70jpL+E7YFDnp5UYJO/S+bWpx+9h92slZ1C9z+FXyiHWq/t1
 tZatBZdZPQxB/xn3OXCcdWJaQjsUN+TofUDaaAWNw+A==
X-Gm-Gg: AeBDies8sCCSmh/L5UP5ccWQF5Nel/D2xNA9M2Cp05Cz5ufyLEB0xmaA3f9JT6zyxYs
 7PInL5yZ7bfJ1BWUiSIDnq/gIRkzxPARW2u8lzi7M8n2A73tiX9DR9GKLDgL4stnDMXMbxLe9H+
 mBTWth6jtIEmH/9vwq+67WUoYZ/8m9J4R9qZQtdNXSV1nL83Sua+dyMKe38SPAhBo8bZiJq0WPD
 qPtDr8824juXJ/zb9wB7a9Megh2qx2MlTI18VWuHlocM0b8GVKtMuazQw5fc/5qGbTntl7wFRB2
 ieR8C/rNxs5DW4HxX38REYeHtKjV
X-Received: by 2002:a05:690e:4811:b0:651:bcc9:50cd with SMTP id
 956f58d0204a3-653107ccddamr6102177d50.5.1776604455299; Sun, 19 Apr 2026
 06:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
 <20260418190456.631df6f3@fedora>
In-Reply-To: <20260418190456.631df6f3@fedora>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Sun, 19 Apr 2026 09:14:04 -0400
X-Gm-Features: AQROBzCejbUFLEO14GEr24qqxXnlBQ97NPzS668jjkdcYvI-3kvv1xuemSCQk44
Message-ID: <CAO7JXPh+__EWsW8fsKi4T+w0jdPxZEfCLQno_ukJk2=d2s0WKA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] tracepoint: Avoid double static_branch
 evaluation at guarded call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 dev@openvswitch.org, Jiri Pirko <jiri@resnulli.us>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Koby Elbaz <koby.elbaz@intel.com>, dri-devel@lists.freedesktop.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Len Brown <lenb@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
 Eddie James <eajames@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, 
 Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Apr 18, 2026 at 7:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 23 Mar 2026 12:00:19 -0400
> "Vineeth Pillai (Google)" <vineeth@bitbyteword.org> wrote:
>
> >   if (trace_foo_enabled() && cond)
> >       trace_call__foo(args);   /* calls __do_trace_foo() directly */
>
> Hi Vineeth,
>
> Could you rebase this series on top of 7.1-rc1 when it comes out?
> Several of these patches were accepted already. Obviously drop those.
> They were the patches that added the feature, and any where the
> maintainer acked the patch.
>
> Now that the feature has been accepted, if you post the patch series
> again after 7.1-rc1 with all the patches that haven't been accepted
> yet, then the maintainers can simply take them directly. As the feature
> is now accepted, there's no dependency on it, and they don't need to go
> through the tracing tree.
>
Sure, will do. Thanks for merging this feature.

Thanks,
Vineeth
