Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB433C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4012C10E198;
	Mon, 24 Aug 2026 20:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Jr2PNKQ2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE90610E198
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 20:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787603754; x=1819139754;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+6TjTAKrTn2VwDEgqq7tGf4NGG5H94m0/s4cDkc+kXA=;
 b=Jr2PNKQ2u0F/sXmJMPFmMtdqxf9dsAtSQSPV5C8KKIB0xC9JD7kP7Y7H
 bxKHEqP0fpAaMWaUjpUqorLRuiQXcMJRX4u92Gos8cC0VM/SHWXHrQfRy
 MwSyWEL2ZU3NSYkAedKTRWASnWQp2jYt07ZcOHMwqD1NKplghw4VO4JBJ
 y0dlyQNRIy5hoZvHMID7CfrH7NL5fQpF78qj/MEPC7VvJxzLsJ5aBU2nl
 uETO5+/Uj9z+A8We4Zef2rqHdPOgwEm7PI0zCYyTjcs1CQyycMabzT0zk
 3epUgZQLAFB8LwBl6sPe8f4MmTku4VktX1UA4bw4Jot8Cz8EVbyURnO1/ g==;
X-CSE-ConnectionGUID: 8MOgSZ5cQyi+u3znpn1bQA==
X-CSE-MsgGUID: Scy9rCozTKqIXAYL8IV3aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87924706"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="87924706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 13:35:53 -0700
X-CSE-ConnectionGUID: TkgwovyXTJ+ZxMAzvU4+Iw==
X-CSE-MsgGUID: l/kZnzeLQn6w7GauCWJemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; d="scan'208";a="297006566"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 13:35:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 13:35:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 13:35:52 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 13:35:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC+4ZwZ+bSxheoo4vRSCIokndCn6pRJGgTkzPIQwmXS1aw7Yf/oWlm7hnb9fSmSDfN01YA7/djOpGM2+Hl/R5GtWVq9fKZbl/cbEzmcDKahyeTydOPAWT26XWaCmZbp+iWx247DMr16zn7kFKCO1WoVPXC7MH/gipVKKAlxcqsol0g937y6Q8l/+6mHQOEWuGf2ovfY8mz+rEcDrngFZyiL/ifUcvNtajPsAkZ51YswQ9OiRpIdOVi++ZROX/6jdFxWVIiQH08D8tbGAEwvLRlXXjuzV4Cc/CyB4sGu5H0RpXO+swvfe1L1oqCQwc4IKo5AposPDgJkp1guGrlchLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asKXVsDeqkMYNZciWyMT+ro8AH35Y+/Nzfb5FAu6QVY=;
 b=gdsePgUSNCj4HvQ7zfzDjn+UuTqGq02bVF0oC3V9LsdBzWzxgX9xKQEwugs/PjTyHewGjtWh7mKF6FAx1iIvFAiU0pm3AH/UbT/LPBYOuaoKNHy/lzJGUNq8y99qW917USjo3Jht5RMe/HnlhQMFY6S2uqd7JVskdFQ8xZ2Lf5mSt8qdPMh1kQIFzL9JOlX/WGspIDDFMMt3r97E2P63NbNm7tTPoBEeszJHpNVjSm0vZfgykz5bEn1JHyb67QhgTcToNIGGZ/+GrmSmSV75FO0RGDYOxtmkZB9hBD9evp2cbucq7sVZG0SbrAbIDvptjNH9VJv3jV60IW+agHy5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by SA2PR11MB5099.namprd11.prod.outlook.com (2603:10b6:806:f9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 20:35:50 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 20:35:50 +0000
Date: Mon, 24 Aug 2026 16:35:44 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 <dri-devel@lists.freedesktop.org>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>, 
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v6] drm/drv: Convert wedged event string building to
 seq_buf
Message-ID: <aoyrIJNnj5U5JsFE@intel.com>
References: <20260823003349.587495-2-mallesh.koujalagi@intel.com>
 <aop1P1xK9fB90AzQ@black.igk.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aop1P1xK9fB90AzQ@black.igk.intel.com>
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|SA2PR11MB5099:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca44ad0-24f6-4f5a-6cb2-08df021f48af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fF+qXw0OAHs4ji8uJDVTDuqAEwAkGFnOMZ9uWn3VN3SGUjP+NR3Yq01YZnIj3bwuIp5gOBEVmNAvD6VVXaP5jMlbF7FJ4L7kmUHKjhny0O6n+ew+p69HPr4wjFQsvmmt1zyX5CNzNB2NpFXNqsLLl2l3HC2SkSizoAM9p/aYw7Z9wq/CgkPRKLfPZnRpZ7P3FfLr8wQuRLRXKXn4bd947WEhLMxFVtagOvSIdJu1NxpbySGPzRRjBhXakwAhFYHWBgj4Ok3o6/SMRXZrgkKbE6FWqbas0uOtLFIEKwEjggH87bshi1MQPwPnZCnUkGG8gA5+wUZn0xdLZ5n1Hlj2FVqi+0riaVZZf0QJZVy1Q/lOKnX+7xBeRPH7a1hOBM1gSL3627UIFjAjIinyyTskVyFlg9WqjqqSM7XdO0loC0FKprl3/eNi0EsWa02+d99ZmBP5fuyxDBuMZL/Zy3qzxWo4w34Hs9N1+dkvWE4ztJiNLz+5tNIMsDkHBf5xQSsb79WNwh0n9I/gaOupqoPFOaspGgFYuOGkfVN1x8mcxTI9CKhHJ3hEq3ZFNiqo/jmuHDzTTte/hiKGFLIRoG+LDIFNNKNSH+dv+tZ6cHuwneLDv4LXfNn4TeYyAvNbKuar7JZiOLmhlVXvc66bTBhsJLsH7GyCsB8YJ1tsLaEgMaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7752.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vh2awVHbL1KZEbubTDy15FSwZ2PnxXRjoYP2eJXJ4c1uiTeO9FbEGz+EDqGj?=
 =?us-ascii?Q?Ocd0Hss+ZvQ/XOC/TsAeiKwGkL4WT4SWzHhvFVfI7dOKig5y1xhAGUInjtp0?=
 =?us-ascii?Q?t2pR5gxQ2n7cBjWRxWrJFV1fRUnm0FgEBKA6km+qaUtwZymfsRnkvla/TjXe?=
 =?us-ascii?Q?fSCe+K4gJb8s87NhEZABHIHSKLbz7WCTognu+63w3EORVzFBfECP/FbcXnma?=
 =?us-ascii?Q?w9qJ+t2w3Hh13cfOi/1Brn4eJqN+xcnHBir5FIOsSQwzrK7G9h9CzTt5OOQ+?=
 =?us-ascii?Q?ZLyDnLuNQ9u6Y1U5MLi7GGLtAZa+pLUSF+zOwN3MMdjYSurVerOZjj7ORRdY?=
 =?us-ascii?Q?C1lajS5/TTwWJn2JYs2NnlYGtfhVW03Nq8HSIh1qqbm0tIIsyplgniXzfqyY?=
 =?us-ascii?Q?7nC7AnRtXRIXPZnlhO0cT8Y0FAj+B5EcZgQjdItm8FK+1RLQensoO0PMcaFO?=
 =?us-ascii?Q?xR4+FEQdEEdGdkdXYftPF/1enXVVQg9hZFpsFjbReEVit0eOM6KpvXEHM6Dc?=
 =?us-ascii?Q?jechzpc8bQvBEisskcmOtJGvNHD9d1cuxAWnuAwjnZay3PiKByZPhcIMYB7J?=
 =?us-ascii?Q?b2dAeusTZYEuv/7d937wDjU2/MvkVYGWYQ+rlqvT0ExtvVgMYz+wGMsqvS0Z?=
 =?us-ascii?Q?yFb/gtayGZWyBzeXajaXi/u2Npz/wixSFToyHKPR+CepK6ceRVX4CP4e1bcq?=
 =?us-ascii?Q?jGOYPlLDkItbkUUeFjdhZLJ0vXSW4rayomECQuZib/G/trDqCRn3CCu8dZfj?=
 =?us-ascii?Q?xvSATv0i1jj3Niwe7vGK1LVVYV+Q6GAa5C1W1LavVjRSH95n2MGbCIRPbQ4X?=
 =?us-ascii?Q?X1Rf4tKO9yGCtR8Qa8M8saWNUJq/Wai/W36CeCpG604+7U2yHzwjSrs6PmDV?=
 =?us-ascii?Q?5FZBnCrn754bxIESqxN62FhcQRrJNZubSzOM7EFyo4vr8yCCIsJ8f4+vFBsp?=
 =?us-ascii?Q?pxobVLYHZtuQjN634lb1s/S8TaEkc04JQN8AjEKAE8TSxBf9I3BlcM++bAD6?=
 =?us-ascii?Q?QmARSkJ6J3zR3StIUEmuujCJJUmQcZNl2KvVPASymJkbex1fWLWOABQ18B5M?=
 =?us-ascii?Q?yI4anzE8JlhTkqB237NIEW9mQ+mvOnZaBK4ggKnmZw4KmaLx4/iN03OSMXw8?=
 =?us-ascii?Q?2jooCybLQCy9E0e5nYG8J30f4O3Xl+IheWMxIi2qj19WUbVDENnONvoke2eh?=
 =?us-ascii?Q?kuBPfzyXvIR7hX8X0BUhgpZ4Cie15VpuzFlwG5H2nK+/j2zv8NSkfWBjfRqM?=
 =?us-ascii?Q?3KwQkHyrt/+tJt3i71PkfmbOlsBx1j8W4+t+1LwtA4epq1ikWTOuX2oeBMF0?=
 =?us-ascii?Q?J8rqtCIuB16HQIlLq7tHvsgSUAdfnFZAKbR8LuXaxmj9HVLbKqmbWi9qwypJ?=
 =?us-ascii?Q?iv1RrWfJhS6bnl02hTqAh0nqUn92WpvLOB2TFwTAwoQjXsg7oQcvRT1Ke0TY?=
 =?us-ascii?Q?V5hR2GXgzG589tXzepGmK+TltVYLpNX2BDzO00gJmWzg79NX0+IbXqsQ/ccS?=
 =?us-ascii?Q?WGTExPUuR6VWQBBS2Wl4QSghFR16JEDMYBn4oUkhsJQi96PvcDQkoQW1+3eH?=
 =?us-ascii?Q?LP34i6ellXXgKcEHm6FGy0eV+tfZzn/Gy16f5s7qxCHO6sU66Y/Je8GbpxeB?=
 =?us-ascii?Q?WZNZsFiUNF1hrMnMp/1oot7IAaIWd76q5SJMcT9MMH6c+mtn6Apoh5bVw88Z?=
 =?us-ascii?Q?HMjX1K/2biNhDH9Q9OvTHWE3deWYid8A1um+zSWoKU6wUB9/qRPolyO+zxmM?=
 =?us-ascii?Q?SPVZ7Rr75w=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZSNOIkAAVWwlqLXIaAGv4WPnBVksq70+RnrvjJQhK0iDnEP/g5BwAyiLC8mJR9YG0KtamPhvvGuX5H0evmB3UuXOiHBCo+JjuSNDjof5DY+jEjjrEcQNJh4xXuQ2gPIqWCOfyoIOczYI3EFomHBwlVifMLfF3yohmlyoSp4QgvDkWdbO61Snir7RW/U72FxcIgnJjkWr6uTofKiZjAWFcj6YjkcW8EfDEgOPr9zuyteuxAmkSMiukle0PF0XbXtbVqegYlIy9abirIV9mTWmISp+TJ+mNq2MHa+iIMKEc2OWlh1u7w8NHlYNguVNQ3SgfUC53sPcIOGv2u3u5xPMyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca44ad0-24f6-4f5a-6cb2-08df021f48af
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 20:35:49.8993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQGKz9UFoFzEkzQO+Lgu+ubyHK8OATFQdc6pYZ1ITIfa/if/avnhe0GQw30WYFnNhiejb4MVzfdnG+x2hqUE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5099
X-OriginatorOrg: intel.com
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

On Sun, Aug 23, 2026 at 06:21:19AM +0200, Raag Jadav wrote:
> On Sun, Aug 23, 2026 at 06:03:50AM +0530, Mallesh Koujalagi wrote:
> > event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> > The original scnprintf()-based loop required a manual pre-flight
> > bounds check.
> > 
> > Replace the manual bookkeeping with seq_buf, which tracks overflow
> > internally. seq_buf_printf() writes each "method," token into the
> > buffer.
> > 
> > On overflow, a warning is issued, len retains the position of the
> > last successful write, so the trailing comma is stripped cleanly
> > without including any partial method name in the uevent payload.
> > 
> > Assisted-by: Claude:claude-Sonnet-4.6
> > Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> 
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>

pushed to drm-misc-next
