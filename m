Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A8CF99C66
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 07:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AED10E028;
	Sat, 18 Apr 2026 07:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/f0b64z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872F910E028
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 07:36:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 34A7A60138;
 Sat, 18 Apr 2026 07:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55573C19424;
 Sat, 18 Apr 2026 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1776497762;
 bh=gTiXdDA1m36BPQIbbpznxBOamYJaGxQ+XahQj8kEMXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M/f0b64zecCZyXr+LWO4QSZDLvjmgzHJREDVPpTBz7IGgJk0sL121jNpp/V+o4Jm2
 HBukvXvvM7b/rJ73KfVncgTWTpFdTGlU4De1H4WsdTi8GSCcdfCCvVJQqDSGIJ5FBc
 uSgkyaCLCOvbHdzdifuKclGA6dgis9hxxag5TV2k=
Date: Sat, 18 Apr 2026 09:35:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 maciej.falkowski@linux.intel.com, Max Zhen <max.zhen@amd.com>,
 linux-kernel@vger.kernel.org, sonal.santan@amd.com
Subject: Re: [PATCH V1] accel/amdxdna: Add hardware scheduler time quantum
 support
Message-ID: <2026041818-tricky-breeching-73d1@gregkh>
References: <20260414165602.788811-1-lizhi.hou@amd.com>
 <f233b761-ca66-4790-bdba-8407e696006b@amd.com>
 <54e62560-22a8-7f1b-642e-21042fc1f081@amd.com>
 <d58e78d3-dd94-4dc5-a80c-5f38836c4495@amd.com>
 <295f2c5c-1c16-96ab-b9b7-c465cc6ee16e@amd.com>
 <1be1c328-f807-45a7-9b54-a265c627e890@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1be1c328-f807-45a7-9b54-a265c627e890@amd.com>
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

On Tue, Apr 14, 2026 at 12:32:20PM -0500, Mario Limonciello wrote:
> 
> 
> On 4/14/26 12:28, Lizhi Hou wrote:
> > 
> > On 4/14/26 10:17, Mario Limonciello wrote:
> > > 
> > > 
> > > On 4/14/26 12:16, Lizhi Hou wrote:
> > > > 
> > > > On 4/14/26 09:58, Mario Limonciello wrote:
> > > > > 
> > > > > 
> > > > > On 4/14/26 11:56, Lizhi Hou wrote:
> > > > > > From: Max Zhen <max.zhen@amd.com>
> > > > > > 
> > > > > > Add support for configuring the hardware scheduler time quantum to
> > > > > > improve fairness across concurrent contexts.
> > > > > > 
> > > > > > The scheduler enforces a fixed time slice per context, preventing
> > > > > > long-running workloads from monopolizing the device and allowing
> > > > > > other contexts to make forward progress.
> > > > > > 
> > > > > > The default time quantum is 30ms and can be configured via the
> > > > > > time_quantum_ms module parameter.
> > > > > 
> > > > > Can you talk more about how you want to use it?  Adding new
> > > > > module parameters is generally frowned upon in lieu of doing
> > > > > something with debugfs at runtime.
> > > > 
> > > > This is a static setting which is not supposed to change at
> > > > runtime. So module parameter is used.
> > > 
> > > But so what happens if user loads driver with default setting and
> > > then unloads driver and loads with a different setting as module
> > > option?
> > > 
> > > Does this flow fall apart because the driver initially programmed 30ms?
> > 
> > Reloading with new setting will overwrite the default setting. After the
> > module is loaded, it is not supposed to change before unloading the
> > module.
> > 
> 
> + Greg
> 
> Greg,
> 
> How do you feel about a module parameter for this purpose?  Any other
> suggestions if you don't like it?

module parameters should almost never never never be added to the
kernel, ESPECIALLY if it is for a device-specific thing (like in a
driver like this.)  Please don't do that.

> I was thinking a debugfs file still makes sense, but either the debugfs file
> can do unbind/rebind internally or user using debugfs file can do the
> unbind/bind sequence in sysfs after touching the debugfs file.

debugfs is for debugging, don't require it for functionality that a
user/admin actually wants to do for a device as many distros and systems
disable it entirely due to all of the security holes it exposes to
admins.

thanks,

greg k-h
