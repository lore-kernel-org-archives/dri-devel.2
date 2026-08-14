Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77610C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E3D10F49F;
	Fri, 14 Aug 2026 09:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aJ7ArCoD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1BF10E52C;
 Fri, 14 Aug 2026 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786699995; x=1818235995;
 h=message-id:subject:from:to:cc:date:
 content-transfer-encoding:mime-version;
 bh=uvThznsaD0oSQ7UnEUlqaxSjj7O+BDeL6PnOtMWzrNI=;
 b=aJ7ArCoDLGRc7SBNqnLKQsVXgupdmVBYE6MjGFFHikKA8WNOIKkZMHIZ
 Q1YlQlwzItqK6NcpgsXEEIwt3dr5EBTN2njFXWF4cbtUElprm+LahcC75
 ppaPcD8L8W1Z/4YIUPz+dBDGYw3m+MjNU1b8+v9HVpz8zd8/nZeJA2dso
 Gx1LyXfOoQc/6qgCKnxlqLFqph0WILlFS1X26J83v1KUml6N08bWMh4U+
 C/6ZQMWslhEhnTgbqP7lIFis1OnM+tIfDKcHDHJMbHd516YZmnfnNARF+
 jfSGsBeEv3oX6Tsa6liHurzlpiXv4aXk0451sy0mp3UBa8x7bTE8DxaxH A==;
X-CSE-ConnectionGUID: En1hggDNSge4gFzW1R+37Q==
X-CSE-MsgGUID: u1+1k+yxSwihGUpYRvxxNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="98636318"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="98636318"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 02:33:10 -0700
X-CSE-ConnectionGUID: YM2JfACfR4GraFEvVObR6A==
X-CSE-MsgGUID: 0rxYIRQSRvCMa/csE7IyaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="261537334"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.164])
 ([10.245.244.164])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 02:33:07 -0700
Message-ID: <894f9d44eae62aee5762495b4f90f9bdd2b5585d.camel@linux.intel.com>
Subject: [RFC] dmisc cgroups controller
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, maarten.lankhorst@linux.intel.com
Cc: intel-xe@lists.freedesktop.org, cgroups@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, pallavi.mishra@intel.com
Date: Fri, 14 Aug 2026 11:32:54 +0200
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

Hi!

We (drm/xe GPU driver) have a use-case where we have a very limited
number of a particular device resource (CLOS slots) that we potentially
want to expose to unprivlieged processes for reservation / allocation.
We want to be able to restrict per cgroups the number of CLOS slots
that are available for reservation / allocation.

This is not a good fit for the misc controller since these resource
types may be added and removed similar to dmem regions. Neither is it a
good fit for the dmem controller.

Would a dmisc controller be suitable here? It would be similar to the
misc countroller but with dynamic addition and removal of resource
types similar to the dmem controller.

Any input greatly appreciated.

Thanks,
Thomas
